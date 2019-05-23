<?php

/**
 * Created by PhpStorm.
 * User: payam
 * Date: 5/16/2017 AD
 * Time: 4:44 PM
 */

namespace Drupal\hotelux\Services;

use Drupal\Core\KeyValueStore\KeyValueFactoryInterface;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\Core\Queue\RequeueException;
use Drupal\Core\Routing\TrustedRedirectResponse;
use Exception;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;

class WebService {

    private $connections;
    private $keyValueFactory;
    protected $logFactory;

    public function __construct(
        KeyValueFactoryInterface $keyValueFactory,
        LoggerChannelFactoryInterface $logFactory,
        $connections
    ) {
        $this->keyValueFactory = $keyValueFactory;
        $this->logFactory = $logFactory;
        $this->connections = $connections;
    }

    public function request($namespace, $request_object, $direct = FALSE) {

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
            }  else {
                $request_params = array_merge($request_params, [
                    'headers' => ["Authorization" => "hotel" ]
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
//            var_dump('req', $request_object['method']);
//            var_dump('url', $service_url);
//            var_dump('params', json_encode($request_params));
            $request = $client->request($request_object['method'], $service_url, $request_params);
        } catch (RequeueException $e) {
            $this->logFactory->get('hotelux')
                ->error($e->getMessage());
        } catch (ClientException $e) {
            $this->logFactory->get('hotelux')
                ->error($e->getMessage());
        } catch (Exception $e) {
            $this->logFactory->get('hotelux')
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
        return new RedirectResponse($config[$url], 302);
    }

    /**
     * return language code (fa/en)
     */
    public function getCurrentLanguage() {
        return \Drupal::languageManager()->getCurrentLanguage()->getId();
    }

}
