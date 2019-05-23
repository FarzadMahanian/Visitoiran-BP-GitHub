$(window).scroll ->
  scrollTop = $(window).scrollTop()
  if scrollTop >= 300
    $('#go-top-btn').css 'right', '30px'
  else if scrollTop < 300
    $('#go-top-btn').css 'right', '-100px'

$ ->
  $('#go-top-btn').click ->
    $('html, body').animate { scrollTop: 0 }, 'slow'