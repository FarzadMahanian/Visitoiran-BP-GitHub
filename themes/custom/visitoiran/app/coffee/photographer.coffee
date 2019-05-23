$ ->
  photographer = $('input#photographer').val()
  $(document).on 'cbox_complete', ->
    if $('#cboxContent #photographer-field').length == 0
      $('#cboxContent').append '<div id="photographer-field"></div>'
    if photographer
      $('#cboxContent #photographer-field').html Drupal.t('Photographer') + ': ' + photographer
    else
      $('#cboxClose').html ""
      addPhotographer = $('#cboxTitle').html()
      if addPhotographer
        index = addPhotographer.indexOf('#')
        if index >= 0
          $('#cboxContent #cboxTitle').html addPhotographer.substring(0, index)
          $('#cboxContent #photographer-field').html Drupal.t('Photographer') + ': ' + addPhotographer.substring(index + 1)
        else
          $('#cboxContent #photographer-field').html addPhotographer
