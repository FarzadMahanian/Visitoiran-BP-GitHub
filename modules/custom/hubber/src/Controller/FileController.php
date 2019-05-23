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
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;

class FileController extends ControllerBase {

    const _NAMESPACE = 'services';
    private $webService;
    protected $loggerFactory;

    public function __construct(WebService $webService, LoggerChannelFactoryInterface $loggerFactory) {
        $this->webService = $webService;
        $this->loggerFactory = $loggerFactory;
    }

    public function getDirect($id) {
        $request_object = [
            'service' => 'getFile',
            'method' => 'GET',
            'query' => [
                'id' => $id
            ]
        ];
        $file_response = $this->webService->request(self::_NAMESPACE, $request_object, true);
        $filename = md5(random_int(100, 1000));

        $response = new Response();
        $disposition = $response->headers->makeDisposition(ResponseHeaderBag::DISPOSITION_INLINE, $filename);
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'image/jpeg');
        $response->setContent($file_response->getBody()->getContents());
        return $response;
    }

    public static function create(ContainerInterface $container) {
        $webService = $container->get('hubber.web_service');
        $loggerFactory = $container->get('logger.factory');
        return new static($webService, $loggerFactory);
    }

}
