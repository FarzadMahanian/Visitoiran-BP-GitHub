<?php

/**
 * Created by PhpStorm.
 * User: payam
 * Date: 5/16/2017 AD
 * Time: 2:47 PM
 */

namespace Drupal\hubber\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\hubber\Services\WebService;
use Symfony\Cmf\Component\Routing\RouteObjectInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class PackageController extends ControllerBase {

    const _NAMESPACE = 'pms';
    const _SUCCESS = 'SUCCESS';
    private $webService;
    protected $loggerFactory;

    public function __construct(WebService $webService, LoggerChannelFactoryInterface $loggerFactory) {
        $this->webService = $webService;
        $this->loggerFactory = $loggerFactory;
    }

    public function login(Request $request) {
        $session = $this->webService->authenticate(
            self::_NAMESPACE,
            $request->get('email'),
            $request->get('password')
        );
        if (!$session) {
            return $this->webService->changeRoute(self::_NAMESPACE, 'login');
        }
        return $this->webService->changeRoute(self::_NAMESPACE, 'profile');
    }

    public function loginPage(Request $request) {
        $this->webService->logout();
        $r = $request->query->all();
        if (!empty($request->get('u'))) {
            $r = array_merge([
                'userName' => $this->webService->hexToStr($request->get('u')),
            ], $r);
        }
        return [
            '#type' => 'page',
            '#theme' => 'loginPage',
            '#searchTerms' => $r
        ];
    }

    public function getUserProfile(Request $request) {
        if (!$this->webService->isAuthenticated()) {
            return $this->webService->changeRoute(self::_NAMESPACE, 'login');
        }
        $request_object = [
            'service' => 'userInfo',
            'method' => 'GET'
        ];
        $userInfo = $this->webService->request(self::_NAMESPACE, $request_object);
        if ($userInfo['code'] == '404') {
            throw new NotFoundHttpException();
        }
        $this->webService->setGlobal([
            'userInfo' => $userInfo
        ]);
        return [
            '#theme' => 'userHome',
            '#profile' => $userInfo['response'],
            '#booklist' => $this->getUserBookList($request)['response'],
            '#searchTerms' => $request->query->all()
        ];
    }

    public function getPackages(Request $request) {
        $query = [
            'page' => 0,
            'total' => 12,
            'order' => 'id',
            'direction' => 'asc',
            'section' => $this->webService->getCurrentLanguage()
        ];

        $request_object = [
            'service' => 'getPackages',
            'method' => 'GET',
            'query' => array_merge($query, $request->query->all())
        ];
        $packages = $this->webService->request(self::_NAMESPACE, $request_object);
        return [
            '#theme' => 'packages',
            '#packages' => $packages,
        ];
    }

    //    @Json
    public function getTopPackages(Request $request) {
        $query = [
            'page' => 0,
            'total' => 4,
            'order' => 'id',
            'direction' => 'asc',
            'section' => $this->webService->getCurrentLanguage()
        ];

        $request_object = [
            'service' => 'getPackages',
            'method' => 'GET',
            'query' => $query
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    public function getPackage(Request $request, $id) {
        if (empty($id)) {
            return FALSE;
        }
        $request_object = [
            'service' => 'getPackage',
            'method' => 'GET',
            'url_parameters' => [$id]
        ];
        $package = $this->webService->request(self::_NAMESPACE, $request_object);
        if ($package['code'] == '404') {
            throw new NotFoundHttpException();
        }
        $this->setPageTitle($request, $package['response']->title);
        return [
            '#theme' => 'package',
            '#package' => $package
        ];
    }

    //    @Json
    public function checkAvailability(Request $request) {
        $request_object = [
            'service' => 'checkAvailability',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function books(Request $request) {
        $request_object = [
            'service' => 'books',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function registerUser(Request $request) {
        $request_object = [
            'service' => 'registerUser',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function updateUser(Request $request) {
        $request_object = [
            'service' => 'updateUser',
            'method' => 'PUT',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function activate(Request $request) {
        $request_object = [
            'service' => 'activate',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function resendActivation(Request $request) {
        $request_object = [
            'service' => 'resendActivation',
            'method' => 'PUT',
            'body' => $request->getContent()
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    public function getUserBookList(Request $request) {
        $query = [
            'page' => 0,
            'total' => 10,
            'order' => 'creationDate',
            'direction' => 'desc'
        ];

        $request_object = [
            'service' => 'userBookList',
            'method' => 'GET',
            'query' => array_merge($query, $request->query->all())
        ];
        return $this->webService->request(self::_NAMESPACE, $request_object);
    }

    private function getPaymentInitialize($bookId) {
        $request_object = [
            'service' => 'paymentInitialize',
            'method' => 'GET',
            'query' => [
                'bookId' => $bookId,
                'gateway' => $this->webService->locales[$this->webService->getCurrentLanguage()]['currency']
            ]
        ];
        return $this->webService->request(self::_NAMESPACE, $request_object);
    }

    public function pay($bookId) {
        if (empty($bookId)) {
            throw new NotFoundHttpException();
        }
        $response = $this->getPaymentInitialize($bookId);
        if ($response['code'] != Response::HTTP_OK || $response['response']->result != self::_SUCCESS) {
            return [
                '#theme' => 'payment',
                '#payment' => $response
            ];
        }
        $uuid = $response['response']->data;

        return $this->webService->redirect(self::_NAMESPACE, 'paymentRedirection', $uuid);
    }

    private function getVouchers($id) {
        $request_object = [
            'service' => 'vouchers',
            'method' => 'GET',
            'query' => [
                'bookId' => $id
            ]
        ];
        return $this->webService->request(self::_NAMESPACE, $request_object);
    }

    public function seeVoucher(Request $request, $bookId) {
        $request_object = [
            'service' => 'vouchers',
            'method' => 'GET',
            'query' => [
                'bookId' => $bookId
            ]
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    public function completePayment(Request $request) {
        $response_query = [];
        $response = [];
        parse_str($request->getQueryString(), $response_query);
        if ($response_query['status'] != self::_SUCCESS) {
            $response = [
                'code' => Response::HTTP_CONFLICT,
                'response' => $response_query
            ];
        }
        else {
            $this->setPageTitle($request, 'Package Voucher');
            if (!$this->webService->isAuthenticated()) {
                $response = [
                    'code' => Response::HTTP_OK,
                    'response' => 'User not Login!',
                    'login' => false
                ];
            } else {
                $response = [
                    'code' => Response::HTTP_OK,
                    'response' => $this->getVouchers($response_query['bookId']),
                    'login' => true,
                ];
            }
        }
        return [
            '#theme' => 'payment',
            '#payment' => $response
        ];
    }

    public static function create(ContainerInterface $container) {
        $webService = $container->get('hubber.web_service');
        $loggerFactory = $container->get('logger.factory');
        return new static($webService, $loggerFactory);
    }

    private function setPageTitle(Request $request, $title) {
        $routes = $request->attributes->get(RouteObjectInterface::ROUTE_OBJECT);
        $routes->setDefault('_title', $title);
    }

}
