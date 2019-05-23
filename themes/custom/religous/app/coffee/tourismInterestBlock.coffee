resetSelected = (selector, callback) ->
    doms = $(selector)
    for dom in doms
        $(dom).removeClass 'selected'
    callback();

$ ->
    $('#tourism-interests-block li').on 'click', (target) ->
        tourismId = target.currentTarget.getAttribute 'tourism-id'
        $('.interest').addClass 'bounceOutRight'
        lang = ''
        if drupalSettings.path.currentLanguage != 'en'
            lang = drupalSettings.path.currentLanguage + '/'
        $.ajax
            url: drupalSettings.path.baseUrl + lang + 'tourismInterests/' + tourismId
            cache: false
            success: (result) ->
                container = $('div.interest');
                container.find('.image').html result[0].field_image
                container.find('.title-text').html result[0].title
                container.find('.body').html result[0].body
                resetSelected '#tourism-interests-block li', ->
                    $(target.currentTarget).addClass 'selected'
    
    rnd = 111 + Math.floor((Math.random() * 9) + 1)
    $('li[tourism-id="' + rnd + '"]').trigger 'click'
