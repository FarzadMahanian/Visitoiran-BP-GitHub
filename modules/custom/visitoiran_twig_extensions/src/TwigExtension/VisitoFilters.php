<?php
namespace Drupal\visitoiran_twig_extensions\TwigExtension;

use Drupal\image\Entity\ImageStyle;
use Morilog\Jalali\jDate;
use Sunra\PhpSimple\HtmlDomParser;

class VisitoFilters extends \Twig_Extension {

    public function getFilters() {
        return [
            new \Twig_SimpleFilter('format_area', array(
                $this,
                'formatArea'
            )),
            new \Twig_SimpleFilter('format_body', array(
                $this,
                'formatBody'
            )),
            new \Twig_SimpleFilter('format_visitoiran_date', array(
                $this,
                'formatJalaliDate'
            ))
        ];
    }

    public function getFunctions() {
        return array(
            'userinfo' => new \Twig_Function_Method($this, 'getUserInfo')
        );
    }

    public function getUserInfo($name) {
        return $_SESSION['pms']['visitoiran']['userInfo']['response']->$name;
    }

    public function getName() {
        return 'visitoiran_twig_extensions.twig_extension';
    }

    public static function formatArea($string) {
        $last_character = substr($string, -1);
        $result = '';
        if ($last_character == 'm') {
            $string = substr($string, 0, -1);
            $result = number_format(trim($string)) . ' ' . t('m²');
        }
        else {
            $result = number_format(trim($string)) . ' ' . t('km²');
        }
        return $result;
    }

    public static function formatJalaliDate($string) {
        $lang = \Drupal::languageManager()->getCurrentLanguage()->getId();
        $date = date('Y/m/d', strtotime($string));
        if ($lang == 'fa') {
            $date = jDate::forge($string)->format('Y/m/d');
        }
        return $date;
    }

    private static function findStyles($body) {
        $needle = "#style#";
        $lastPos = 0;
        $positions = array();
        while (($lastPos = strpos($body, $needle, $lastPos)) !== FALSE) {
            $positions[] = $lastPos;
            $lastPos = $lastPos + strlen($needle);
        }
        return $positions;
    }

    private static function createImages($original_images) {
        $images = '';
        $process_img = HtmlDomParser::str_get_html($original_images);
        $found_images = $process_img->find('img');

        if (count($found_images) == 1) {
            $image_src = str_replace('/sites/default/files/', 'public://', urldecode($found_images[0]->src));
            $images .= '<img alt="' . $found_images[0]->alt . '" src="' . ImageStyle::load('story_big')
                    ->buildUrl($image_src) . '"/>';
        }
        else {
            if (count($found_images) == 2) {
                $image_src = str_replace('/sites/default/files/', 'public://', urldecode($found_images[0]->src));
                $images .= '<img alt="' . $found_images[0]->alt . '" src="' . ImageStyle::load('story_horizontal')
                        ->buildUrl($image_src) . '"/>';
                $image_src = str_replace('/sites/default/files/', 'public://', urldecode($found_images[1]->src));
                $images .= '<img alt="' . $found_images[1]->alt . '" src="' . ImageStyle::load('story_horizontal')
                        ->buildUrl($image_src) . '"/>';
            }
            else {
                if (count($found_images) >= 3) {
                    $image_src = str_replace('/sites/default/files/', 'public://', urldecode($found_images[0]->src));
                    $images .= '<img alt="' . $found_images[0]->alt . '" src="' . ImageStyle::load('story_vertical')
                            ->buildUrl($image_src) . '"/>';
                    $image_src = str_replace('/sites/default/files/', 'public://', urldecode($found_images[1]->src));
                    $images .= '<img alt="' . $found_images[1]->alt . '" src="' . ImageStyle::load('story_small')
                            ->buildUrl($image_src) . '"/>';
                    $image_src = str_replace('/sites/default/files/', 'public://', urldecode($found_images[2]->src));
                    $images .= '<img alt="' . $found_images[2]->alt . '" src="' . ImageStyle::load('story_small')
                            ->buildUrl($image_src) . '"/>';
                }
            }
        }
        return $images;
    }


    public static function formatBody($body) {
        if (strpos($body, '#story#')) {
            $isStory = 'story';
        }
        else {
            $isStory = '';
        }

        // -------------------- Find Styles --------------------
        $positions = self::findStyles($body);

        // -------------------- Create Sections --------------------
        if (!empty($positions)) {
            $sections = array();
            for ($i = 0; $i < count($positions); $i++) {
                if ($i == count($positions) - 1) {
                    $sections[$i] = substr($body, $positions[$i]);
                }
                else {
                    $sections[$i] = substr($body, $positions[$i], $positions[$i + 1] - $positions[$i]);
                }
            }
        }
        else {
            return $body;
        }
        // -------------------- End Create Sections --------------------

        $returnBody = '';
        for ($i = 0; $i < count($sections); $i++) {
            $header = '';
            $subHeader = '';
            $extraText = '';
            $sectionType = $sections[$i][7];
            $html = HtmlDomParser::str_get_html($sections[$i]);
            if (!empty($html->find('h2'))) {
                $header = '<h2 class="with-bullet">' . $html->find('h2', 0)->innertext . '</h2>';
            }
            if (!empty($html->find('h3'))) {
                $subHeader = '<h3>' . $html->find('h3', 0)->innertext . '</h3>';
            }
            if (!empty($html->find('h6'))) {
                $extraText =  $html->find('h6', 0)->innertext;
            }
            $texts = '';
            $original_images = '';
            $story_class = '';

            // -------------------- Find original Images --------------------
            if (count($html->find('img')) > 0) {
                foreach ($html->find('img') as $img) {
                    $original_images .= $img->outertext;
                    $img->outertext = '';
                }
                $html->save();
                $process_img = HtmlDomParser::str_get_html($original_images);
                $found_images = $process_img->find('img');
                // -------------------- Create Images --------------------
                $images = self::createImages($original_images);
            }
            else {
                $found_images = [];
                $images = '';
            }
            // -------------------- End Find original Images --------------------

            // -------------------- Find original Text --------------------
            if (count($html->find('p')) > 0) {
                foreach ($html->find('p') as $p) {
                    $texts .= $p->innertext;
                }
            }
            else {
                $texts = '';
            }
            // -------------------- End Find original Text --------------------

            switch ($sectionType) {
                case 'L':
                    if (count($found_images) == 0) {
                        $returnBody .= $html;
                    }
                    elseif (count($found_images) == 1) {
                        $story_class = 'one-pic-left';
                    }
                    elseif (count($found_images) == 2 || count($found_images) > 3) {
                        $story_class = 'two-pic-left';
                    }
                    elseif (count($found_images) == 3) {
                        $story_class = 'three-pic-left';
                    }
                    $returnBody .= '<section class="clearfix formatted-body">' .
                            '<div class="grid-2 ' . $story_class . '">' .
                                $header . $subHeader .
                                '<div class="image-section">' . $images . '<p class="extra-text">' . $extraText . '</p></div>' .
                                '<div class="text-section">' . $texts . '</div>' .
                            '</div>' .
                        '</section>';
                    break;
                case 'R':
                    if (count($found_images) == 0) {
                        $returnBody .= $html;
                    }
                    elseif (count($found_images) == 1) {
                        $story_class = 'one-pic-right';
                    }
                    elseif (count($found_images) == 2 || count($found_images) > 3) {
                        $story_class = 'two-pic-right';
                    }
                    elseif (count($found_images) == 3) {
                        $story_class = 'three-pic-right';
                    }
                    $returnBody .= '<section class="clearfix formatted-body">' .
                            '<div class="grid-2 ' . $story_class . '">' .
                                $header . $subHeader .
                                '<div class="image-section">' . $images . '<p class="extra-text">' . $extraText . '</p></div>' .
                                '<div class="text-section">' . $texts . '</div>' .
                            '</div>' .
                        '</section>';
                    break;
                case 'T':
                    if (count($found_images) > 0) {
                        $story_class = 'one-picture-top';
                        $image_src = str_replace('/sites/default/files/', 'public://', $found_images[0]->src);
                        $images = '<img alt="' . $found_images[0]->alt . '" src="' . ImageStyle::load('story_horizontal')
                                ->buildUrl($image_src) . '"/>';
                        $returnBody .= '<section class="clearfix formatted-body">' .
                                '<div class="' . $story_class . '">' .
                                    $header . $subHeader .
                                    '<div class="image-section">' . $images . '<p class="extra-text">' . $extraText . '</p></div>' .
                                    '<div class="text-section">' . $texts . '</div>' .
                                '</div>' .
                            '</section>';
                    }
                    else {
                        $returnBody .= '<section class="clearfix formatted-body">' .
                                '<div class="' . $story_class . '">' .
                                    $header . $subHeader .
                                    '<div class="text-section">' . $texts . '</div>' .
                                '</div>' .
                            '</section>';
                    }
                    break;
                case 'F':
                    if (count($found_images) >= 2) {
                        $story_class = 'four-pic';
                        $counter = 500;
                        while ($texts[$counter] !== '.') {
                            $counter++;
                        }
                        $first_text = substr($texts, 0, $counter + 1);
                        $second_text = substr($texts, $counter + 1);
                        $images = [];
                        $image_src = str_replace('/sites/default/files/', 'public://', $found_images[0]->src);
                        $images[0] = '<img alt="' . $found_images[0]->alt . '" src="' . ImageStyle::load('story_big')
                                ->buildUrl($image_src) . '"/>';
                        $image_src = str_replace('/sites/default/files/', 'public://', $found_images[1]->src);
                        $images[1] = '<img alt="' . $found_images[1]->alt . '" src="' . ImageStyle::load('story_big')
                                ->buildUrl($image_src) . '"/>';
                        $returnBody .= '<section class="clearfix formatted-body">' .
                                '<div class="' . $story_class . '">' .
                                    $header . $subHeader .
                                    '<div class="top-section">' .
                                        '<div class="image-section">' . $images[0] . '</div>' .
                                        '<div class="text-section">' . $first_text . '</div>' .
                                    '</div>' .
                                    '<div class="bottom-section">' .
                                        '<div class="image-section">' . $images[1] . '</div>' .
                                        '<p class="extra-text">' . $extraText . '</p>'.
                                        '<div class="text-section">' . $second_text . '</div>' .
                                    '</div>' .
                                '</div>' .
                            '</section>';
                    }
                    else {
                        $returnBody .= '<section class="clearfix formatted-body">' .
                            $header . $subHeader .
                                '<div class="' . $story_class . '">' .
                                    $header . $subHeader .
                                    '<div class="image-section">' . $images . '<p class="extra-text">' . $extraText . '</p></div>' .
                                    '<div class="text-section">' . $texts . '</div>' .
                                '</div>' .
                            '</section>';
                    }
                    break;
                default:
                    $returnBody .= '<section class="clearfix formatted-body">' .
                            '<div class="' . $story_class . '">' .
                                $header . $subHeader .
                                '<div class="image-section">' . $images . '<p class="extra-text">' . $extraText . '</p></div>' .
                                '<div class="text-section">' . $texts . '</div>' .
                            '</div>' .
                        '</section>';
            }
        }

        return '<div type="' . $isStory . '">' . $returnBody . '</div>';

    }


}
