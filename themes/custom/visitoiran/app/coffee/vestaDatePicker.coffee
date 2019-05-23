$ ->
  language = 'en'
  if drupalSettings.path.currentLanguage != 'en'
    language = drupalSettings.path.currentLanguage
  calendar = 'gregorian'
  if language == 'fa'
    calendar = 'persian'
  $('input.vesta-dp').vestadp
    dateFormat: 'yy-mm-dd'
    direction: 'ltr'
    showFooter: false
    persianNumbers: false
    language: language
    calendar: calendar