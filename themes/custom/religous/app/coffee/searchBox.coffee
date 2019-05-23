$ ->
    $('.search-button').on 'click', ->
        $('#block-religous-search').fadeIn 'fast'
        $('#block-religous-search input[type=search]').focus()
        setTimeout (->
            $('#block-religous-search input[type=search]').addClass 'animation-scale-in'
            $('.search-button').addClass 'search-button-in'
        ), 100

    $('#block-religous-search input[type=search]').on 'blur', ->
        $('#block-religous-search input[type=search]').removeClass 'animation-scale-in'
        $('.search-button').removeClass 'search-button-in'
        $('#block-religous-search').fadeOut 'fast'
