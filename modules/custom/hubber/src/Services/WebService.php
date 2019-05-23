<?php

/**
 * Created by PhpStorm.
 * User: payam
 * Date: 5/16/2017 AD
 * Time: 4:44 PM
 */

namespace Drupal\hubber\Services;

use Drupal\Core\KeyValueStore\KeyValueFactoryInterface;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\Core\Queue\RequeueException;
use Drupal\Core\Routing\TrustedRedirectResponse;
use Drupal\hubber\Controller\Session;
use Exception;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;

class WebService {
    
    private $connections;
    private $keyValueFactory;
    private $oauth_try = FALSE;
    protected $logFactory;
    public $locales = [
        'en' => ['currency' => 'DOLLAR'],
        'fa' => ['currency' => 'RIAL']
    ];

    public function __construct(
        KeyValueFactoryInterface $keyValueFactory,
        LoggerChannelFactoryInterface $logFactory,
        $connections
    ) {
        $this->keyValueFactory = $keyValueFactory;
        $this->logFactory = $logFactory;
        $this->connections = $connections;
    }

    public function isAuthenticated() {
//        $tokens = $this->keyValueFactory->get('tokens');
        if (!empty(Session::get('token'))) {
            return Session::get('token');
        }
        return FALSE;
    }

    public function authenticate($namespace, $username = NULL, $password = NULL) {
        $config = $this->connections[$namespace];
//        $tokens = $this->keyValueFactory->get('tokens');
        if (!empty(Session::get('token'))) {
            return Session::get('token');
        }
        Session::startSession();

        $client = new Client();
        try {
            $request = $client->request('POST', $config['token_path'], [
                'form_params' => [
                    'grant_type' => 'password',
                    'username' => $username,
                    'password' => $password
                ]
            ]);
            $oauth = json_decode($request->getBody());
        } catch (Exception $e) {
            $error = json_decode($e->getResponse()->getBody()->getContents());
            drupal_set_message(t($error->error_description), 'error');
            $this->logFactory->get('hubber')
                ->error($e->getMessage());
            return FALSE;
        }
        if (!empty($oauth)) {
            Session::set('token', $oauth->access_token);
//            $tokens->set($username, $oauth->access_token);
            return $oauth->access_token;
        }
        return FALSE;
    }

    public function request($namespace, $request_object, $direct = FALSE) {
        $token = self::isAuthenticated();

        $config = $this->connections[$namespace];
        $web_service_config = [
            'base_uri' => $config['url'] . $config['api'],
            'timeout' => $this->connections['timeout']
        ];

        $client = new Client($web_service_config);
        $service_url = $config['services'][$request_object['service']];
        if (!empty($request_object['url_parameters'])) {
            $service_url .= '/';
            $service_url .= implode('/', $request_object['url_parameters']);
        }
        $response_object = [];
        $request = [];
        try {
            $request_params = [
                'debug' => FALSE
            ];
            if (!empty($config['token_path']) && !empty($token)) {
                $request_params = array_merge($request_params, [
                    'headers' => ["Authorization" => "bearer " . $token]
                ]);
            }
            if (!empty($request_object['query'])) {
                $request_params = array_merge($request_params, [
                    'query' => $request_object['query']
                ]);
            }
            if (!empty($request_object['json'])) {
                $request_params = array_merge($request_params, [
                    'json' => $request_object['json']
                ]);
            }
            if (!empty($request_object['body'])) {
                $request_params = array_merge($request_params, [
                    'body' => $request_object['body']
                ]);
            }
//            var_dump('req', $request_object['method']);
//            var_dump('url', $service_url);
//            var_dump('params', json_encode($request_params));
            $request = $client->request($request_object['method'], $service_url, $request_params);
        } catch (RequeueException $e) {
            $this->logFactory->get('hubber')
                ->error($e->getMessage());
        } catch (ClientException $e) {
            $this->logFactory->get('hubber')
                ->error($e->getMessage());
            if ($e->getCode() == Response::HTTP_UNAUTHORIZED) {
                $store = $this->keyValueFactory->get('oauth');
                $store->delete($config['namespace']);
                if (!$this->oauth_try) {
                    $this->logout();
                    $this->oauth_try = TRUE;
                    $response_object = $this->request($namespace, $request_object);
                }
            }
        } catch (Exception $e) {
            $this->logFactory->get('hubber')
                ->error($e->getMessage());
        }

        if (!empty($response_object)) {
            return $response_object;
        }

        if (isset($e) && $e->getCode() != Response::HTTP_UNAUTHORIZED && $e instanceof Exception) {
            $response_object = [
                'code' => $e->getResponse()->getStatusCode(),
                'response' => json_decode($e->getResponse()
                    ->getBody()
                    ->getContents())
            ];
        }
        else {
            if ($direct) {
                return $request;
            }
            $response_object = [
                'code' => $request->getStatusCode(),
                'response' => json_decode($request->getBody())
            ];
        }

        return $response_object;
    }

    public function jsonRequestResponse($namespace, $request_object) {
        $result = $this->request($namespace, $request_object);
        $response = new JsonResponse($result['response'], $result['code']);
        return $response;
    }

    public function redirect($namespace, $redirection, $id = NULL, $headers = array()) {
        $config = $this->connections[$namespace];
        $redirect_url = $config['url'] . $config[$redirection];
        if (!empty($id)) {
            $redirect_url .= $id;
        }
        if (!empty($headers)) {
            return new TrustedRedirectResponse($redirect_url, 302, $headers);
        }
        return new TrustedRedirectResponse($redirect_url, 302);
    }

    public function changeRoute($namespace, $url) {
        $config = $this->connections[$namespace];
        $lang = '';
        if ($this->getCurrentLanguage() != 'en' ) {
            $lang = '/' . $this->getCurrentLanguage();
        }
        return new RedirectResponse( $lang . $config[$url], 302);
    }

    public function setGlobal($parameter) {
        if (empty(Session::get('visitoiran'))) {
            Session::set('visitoiran', array());
        }
        Session::set('visitoiran', array_merge(Session::get('visitoiran'), $parameter));
    }

    public function logout() {
        Session::destroy();
    }

    /**
     * return language code (fa/en)
     */
    public function getCurrentLanguage() {
        return \Drupal::languageManager()->getCurrentLanguage()->getId();
    }

    public function hexToStr($hex){
        $string='';
        for ($i=0; $i < strlen($hex)-1; $i+=2){
            $string .= chr(hexdec($hex[$i].$hex[$i+1]));
        }
        return $string;
    }

}
