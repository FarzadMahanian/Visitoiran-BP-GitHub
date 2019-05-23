<?php
/**
 * Created by PhpStorm.
 * User: payam
 * Date: 5/27/2017 AD
 * Time: 12:11 PM
 */

namespace Drupal\hubber\Controller;


use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\hubber\Services\WebService;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\HttpFoundation\Request;

class SecurityController extends ControllerBase {

    const _NAMESPACE = 'security';
    private $webService;
    protected $loggerFactory;

    public function __construct(WebService $webService, LoggerChannelFactoryInterface $loggerFactory) {
        $this->webService = $webService;
        $this->loggerFactory = $loggerFactory;
    }

    //    @Json
    public function changePassword(Request $request) {
        $request_object = [
            'service' => 'changePassword',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function resetPassword(Request $request) {
        $request_object = [
            'service' => 'resetPassword',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    //    @Json
    public function resetPasswordRequest(Request $request) {
        $request_object = [
            'service' => 'resetPasswordRequest',
            'method' => 'POST',
            'json' => json_decode($request->getContent())
        ];
        return $this->webService->jsonRequestResponse(self::_NAMESPACE, $request_object);
    }

    public static function create(ContainerInterface $container) {
        $webService = $container->get('hubber.web_service');
        $loggerFactory = $container->get('logger.factory');
        return new static($webService, $loggerFactory);
    }

}
