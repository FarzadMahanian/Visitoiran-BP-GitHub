$ ->
  stories = $('div[type=story]')
  if stories.length > 0
    stories.each (index, value) ->
      $(this).attr 'id','day-' + parseInt(index + 1) + '-section'

  $('.percentage-day .day').click ->
    $('html, body').animate { scrollTop: $('#' + $(this).attr('href')).offset().top - 100 }, 'slow'