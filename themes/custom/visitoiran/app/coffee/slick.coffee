$ ->
  rtl = $('html').attr('dir') == 'rtl'
  r = $('.field--name-field-related')

  i = 0
  while i < r.length
    c = $(r[i]).parents('.content').attr('item-count')
    c = parseInt(c)
    if c > 3
      c = 4
      $(r[i]).slick
        rtl: rtl
        infinite: true
        slidesToShow: c
        slidesToScroll: 4
        dots: true
        autoplay: true
        autoplaySpeed: 5000
        cssEase: 'ease-out'
        easing: 'ease-out'
        responsive: [
          {
            breakpoint: window.resposive.desktop,
            settings: {
              arrows: false,
              slidesToShow: 3,
              slidesToScroll: 3,
              infinite: true,
              dots: true
            }
          },
          {
            breakpoint: window.resposive.tablet,
            settings: {
              arrows: false,
              slidesToShow: 2,
              slidesToScroll: 2,
              dots: false
            }
          },
          {
            breakpoint: window.resposive.landscape,
            settings: {
              arrows: false,
              slidesToShow: 1,
              slidesToScroll: 1,
              dots: false
            }
          }
        ]
    i++

  f = $('.field--name-field-full-screen')

  i = 0
  while i < f.length
    $(f[i]).slick
      rtl: rtl
      infinite: true
      speed: 500
      fade: true
      autoplay: true
      autoplaySpeed: 5000
      cssEase: 'ease-out'
      easing: 'ease-out'
      responsive: [
        {
          breakpoint: window.resposive.tablet,
          settings: {
            arrows: false,
            fade: false,
            dots: false,
            slidesToShow: 1,
            slidesToScroll: 1
          }
        }
      ]
    i++
