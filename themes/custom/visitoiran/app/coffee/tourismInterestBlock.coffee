resetSelected = (selector, callback) ->
  doms = $(selector)
  for dom in doms
    $(dom).removeClass 'selected'
  callback();

$ ->
  $('#tourism-interests-block li').on 'click', (target) ->
    tourismId = target.currentTarget.getAttribute 'tourism-id'
    tourismType = target.currentTarget.getAttribute 'type'
    $('.interest').addClass 'bounceOutRight'
    lang = ''
    if drupalSettings.path.currentLanguage != 'en'
      lang = drupalSettings.path.currentLanguage + '/'
    $.ajax
      url: drupalSettings.path.baseUrl + lang + 'tourismInterests/' + tourismId
      cache: false
      success: (result) ->
        container = $('div.interest')
        container.html ''
        for r in result
          container.append """
                                        <div class='tourism-row'>
                                        <div class="image">#{r.field_image}</div>
                                        <div class="description">
                                            <h2 class="title-text">#{r.title}</h2>
                                            <div class="body">#{r.body}</div>
                                        </div>
                                        </div>
                                        """
          break unless lang

        $('.about-interest').html '<a href="' + lang + 'type/' + tourismType + '">' + $(target.currentTarget).html() + '</a>'
        resetSelected '#tourism-interests-block li', ->
          $(target.currentTarget).addClass 'selected'

  lis = $('#tourism-interests-block li')
  rnd = Math.floor((Math.random() * (lis.length - 1)))
  $($('#tourism-interests-block li')[rnd]).trigger 'click'
