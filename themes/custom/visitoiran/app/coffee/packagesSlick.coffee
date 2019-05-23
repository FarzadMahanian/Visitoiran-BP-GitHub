$ ->
  rtl = $('html').attr('dir') == 'rtl'
  $('.package-pictures').slick
    rtl: rtl
    dots: false
    infinite: true
    speed: 500
    fade: true
    cssEase: 'linear'
    autoplay: true
    autoplaySpeed: 3000
    arrows: true
  $('.package-pictures .picture').css 'display', 'block'