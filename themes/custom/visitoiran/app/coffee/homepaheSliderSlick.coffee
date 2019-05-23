$ ->
  rtl = $('html').attr('dir') == 'rtl'
  $('.region-slideshow .view-content').slick
    rtl: rtl
    dots: true
    infinite: true
    speed: 500
    fade: true
    cssEase: 'linear'
    autoplay: true
    autoplaySpeed: 3000
    arrows: false
  $('.region-slideshow .view-content .slide-slider').css 'display', 'block'