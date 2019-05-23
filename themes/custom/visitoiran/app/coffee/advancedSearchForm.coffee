$ ->
  $('.advanced-search-form .title').click ->
    $('.advanced-search-form form').toggle 'slow', ->
      $('.advanced-search-form form').css 'height', 'auto'

