$ ->
  setTimeout ->
    $('.hotel-filter-top .room-row input.room-field').roomDetail()


# Hotels Slick
$ ->
  rtl = $('html').attr('dir') == 'rtl'
  $('.hotel-gallery .slider-for').slick
    slidesToShow: 1
    slidesToScroll: 1
    arrows: false
    fade: true
    asNavFor: '.slider-nav'
  $('.hotel-gallery .slider-nav').slick
    slidesToShow: 3
    slidesToScroll: 1
    asNavFor: '.slider-for'
    dots: false
    centerMode: true
    focusOnSelect: true
    arrows: false
  $('.hotel-gallery .picture').css 'display', 'block'
