$ ->
    if drupalSettings.path.currentLanguage == 'en'
        moreLink = '<a class="read-more" href="#">Read More</a>'
        lessLink = '<a class="read-less" href="#">Read Less</a>'
    else
        moreLink = '<a class="read-more" href="#">بیشتر</a>'
        lessLink = '<a class="read-less" href="#">کمتر</a>'
    if $('.static-page').length > 0
        h = 500
    else
        h = 300
    $('.readmore').readmore
        speed: 500
        collapsedHeight: h
        moreLink: moreLink
        lessLink: lessLink
