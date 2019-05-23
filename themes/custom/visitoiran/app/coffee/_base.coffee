window.$ = jQuery
window.VOI = {}
window.resposive = {
  landscape: 628,
  tablet: 942,
  desktop: 1250,
}

$ ->
  $.fn.commaSeparator = ->
    @each ->
      $(this).text $(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')
      return
  $('span.price-cell').commaSeparator()

makeVestaDate = (value, lang) ->
  if value
    if lang == 'fa'
      date = new Date(value)
      gdate = new gregorianCalendar(date.getFullYear(), date.getMonth()+1, date.getDate())
      jd = gdate.getJulianDay();
      pdate = persianCalendar.fromJulianDay(jd)
      pdate = new persianCalendar(pdate.year, pdate.month, pdate.day);
      return pdate.toString('yy/mm/dd')
    else
      date = new Date(value)
      gdate = new gregorianCalendar(date.getFullYear(), date.getMonth()+1, date.getDate())
      return gdate.toString('yy/mm/dd')
  value

setCustomMessage = (header, body, type) ->
  $('#messages-container .custom-messages').html ""
  $('#messages-container .custom-messages').append """
    <div class="ui #{type} message">
      <i class="close icon"></i>
      <div class="header">#{Drupal.t(header)}</div>
      <p>#{Drupal.t(body)}</p>
    </div>
  """
  $('.message .close').on 'click', ->
    $(this).closest('.message').transition 'fade'

window.VOI.getTopPackeges = ->
  lang = ''
  if drupalSettings.path.currentLanguage != 'en'
    lang = '/' + drupalSettings.path.currentLanguage
  $.ajax
    url: lang + '/package/top'
    method: 'POST'
    contentType: 'application/json'
    success: (result) ->
      packages = result.content
      topPackagesData = ''
      if packages.length == 4
        $('#home-top-packages').css 'display', 'block'
        for p in packages
          topPackagesData += """
            <div class="column">
                <div class="ui link cards">
                    <div class="card">
                        <a href="package/#{p.id}">
                            <div class="image">
                                <div class="ui top right attached label duration">
                                    <h4>#{p.duration} #{Drupal.t('Days')}</h4>
                                </div>
          """
          if p.logoId
            topPackagesData += """
              <div class="package-logo" style="background-image: url('direct/#{p.logoId}')"></div>
            """
          else
            topPackagesData += """
              <div class="package-logo no-photo"></div>
            """
          topPackagesData += """
                            </div>
                            <div class="content">
                                <div class="header">#{p.title}</div>
                            </div>
                            <div class="extra price">
                                <div>
                                    #{Drupal.t('Start From')}: <strong><span class="price-cell">#{p.minPrice} #{Drupal.t('$')}</span></strong>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
          """
        $('#home-top-packages .packages-list-container').append(topPackagesData)
        $ ->
          $('.special.cards .image').dimmer on: 'hover'
        $('span.price-cell').commaSeparator()
    error: (errorLog) ->
      console.log 'An error has occurred during getTopPackages!'
      console.log errorLog
