$ ->
  $('.search-button').on 'click', ->
    $('#block-visitoiran-search').fadeIn 'fast'
    $('#block-visitoiran-search input[type=search]').focus()
    setTimeout (->
      $('#block-visitoiran-search input[type=search]').addClass 'animation-scale-in'
      $('.search-button').addClass 'search-button-in'
    ), 100

  $('#block-visitoiran-search input[type=search]').on 'blur', ->
    $('#block-visitoiran-search input[type=search]').removeClass 'animation-scale-in'
    $('.search-button').removeClass 'search-button-in'
    $('#block-visitoiran-search').fadeOut 'fast'
