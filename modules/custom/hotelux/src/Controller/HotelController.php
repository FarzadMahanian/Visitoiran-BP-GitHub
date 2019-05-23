<?php

/**
 * Created by PhpStorm.
 * User: payam
 * Date: 5/16/2017 AD
 * Time: 2:47 PM
 */

namespace Drupal\hotelux\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\hotelux\Services\WebService;
use Symfony\Cmf\Component\Routing\RouteObjectInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class HotelController extends ControllerBase {

    const _NAMESPACE = 'hms';
    const _SUCCESS = 'SUCCESS';
    private $webService;
    protected $loggerFactory;

    public function __construct(WebService $webService, LoggerChannelFactoryInterface $loggerFactory) {
        $this->webService = $webService;
        $this->loggerFactory = $loggerFactory;
    }

    public function getHotels(Request $request) {
        $default_parameters = [
            'apiCallChannel' => 'web',
            'availabilityStatus' => 'R',
            'page' => $request->get('pageNo') || 1,
            'language' => $this->webService->getCurrentLanguage(),
            'numberOfResults' => 10,
            'includeDetails' => true,
            'includeFeeRange' => true,

        ];
        $request_object = [
            'service' => 'getHotels',
            'method' => 'POST',
            'json' => array_merge($default_parameters, $request->query->all())
        ];
        $hotels = $this->webService->request(self::_NAMESPACE, $request_object);
        return [
            '#theme' => 'hotels',
            '#hotels' => $hotels,
        ];
    }

    public function getHotel(Request $request, $id) {
        if (empty($id)) {
            return FALSE;
        }
        $default_parameters = [
            'apiCallChannel' => 'web',
            'hotelId' => $id,
            'language' => $this->webService->getCurrentLanguage(),
            'options' => "DEFAULT"
        ];
        $request_object = [
            'service' => 'getHotel',
            'method' => 'POST',
            'json' => array_merge($default_parameters, $request->query->all())
        ];
        $hotel = $this->webService->request(self::_NAMESPACE, $request_object);
        if ($hotel['code'] == '404') {
            throw new NotFoundHttpException();
        }
        $this->setPageTitle($request, $hotel['response']->HotelSummary->Name);
        return [
            '#theme' => 'hotel',
            '#hotel' => $hotel
        ];
    }

    //    @Json
    public function autocomplete(Request $request, $text) {
        $request_object = [
            'service' => 'autocomplete',
            'method' => 'GET',
            'url_parameters' => [$text]
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    public static function create(ContainerInterface $container) {
        $webService = $container->get('hotelux.web_service');
        $loggerFactory = $container->get('logger.factory');
        return new static($webService, $loggerFactory);
    }

    private function setPageTitle(Request $request, $title) {
        $routes = $request->attributes->get(RouteObjectInterface::ROUTE_OBJECT);
        $routes->setDefault('_title', $title);
    }

}
