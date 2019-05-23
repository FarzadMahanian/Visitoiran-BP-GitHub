<?php
/**
 * Created by PhpStorm.
 * User: payam
 * Date: 8/21/2017 AD
 * Time: 4:12 PM
 */

namespace Drupal\hubber\Controller;

class Session {

    private static $started = FALSE;

    public static function startSession() {
        if (!self::$started) {
            session_start();
        }
        $_SESSION['pms'] = array();
        self::$started = TRUE;
    }

    public static function get($name) {
        if (!isset($_SESSION['pms'][$name])) {
            return '';
        }
        return $_SESSION['pms'][$name];
    }

    public static function set($name, $value) {
        $_SESSION['pms'][$name] = $value;
    }

    public static function destroy() {if (isset($_SESSION['pms'])) {
            unset($_SESSION['pms']);
//            session_destroy();
        }
        self::$started = FALSE;
    }

}
