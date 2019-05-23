$ ->
  if drupalSettings.path.currentLanguage == 'en'
    moreLink = '<a class="read-more" href="#">Read More</a>'
    lessLink = '<a class="read-less" href="#">Read Less</a>'
  else
    moreLink = '<a class="read-more" href="#">بیشتر</a>'
    lessLink = '<a class="read-less" href="#">کمتر</a>'
  if $('.static-page').length > 0
    h = 600
  else
    h = 300
  if $('.gardi-page').length > 0
    h = 3000

  dataHeight = $('.content-wrapper').attr 'data-readmore-height'
  if !!dataHeight
    dataHeight = parseInt(dataHeight, 10)
    if dataHeight == 0
      h = 3000
    else
      h = dataHeight


  readMore = $('.readmore')
  for block in readMore
    if $(block).find('.formatted-body').length == 0
      $(block).readmore
        speed: 500
        collapsedHeight: h
        moreLink: moreLink
        lessLink: lessLink


#  $('.readmore').readmore
#    speed: 500
#    collapsedHeight: h
#    moreLink: moreLink
#    lessLink: lessLink