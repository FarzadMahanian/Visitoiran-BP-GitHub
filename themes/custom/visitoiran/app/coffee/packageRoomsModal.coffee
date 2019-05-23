pageLang = ''
if drupalSettings.path.currentLanguage != 'en'
  pageLang = drupalSettings.path.currentLanguage

currency = null

window.VOI.openChooseRoomModal = (hotelPackageString, specialInfoString) ->

  packageInfo = JSON.parse specialInfoString
  hotelPackage = JSON.parse hotelPackageString

  window.VOI.checkAvailability = ->
    packageForCheck =
      hotelPackageRoomTypes: []

    packageForCheck.packageId = packageInfo.packageId
    packageForCheck.hotelPackageId = packageInfo.hotelPackageId
    packageForCheck.hotelPackageDateId = hotelPackage.hotelPackageDateId

    totalPassengers = $('.package-total-section').find('.total-passengers span').html()
    packageForCheck.numberOfPassengers = parseInt totalPassengers, 10

    rooms = $('#choose-package-rooms .choose-package-room-row')
    for room in rooms
      packageForCheck.hotelPackageRoomTypes.push
        hotelPackageRoomTypeId: parseInt $(room).attr('room-id'), 10
        numberOfRooms: parseInt $(room).find('.between-btn').html(), 10

    createPackageDTO(packageForCheck, packageInfo.logoURL)

  window.VOI.bookPackage = ->
    packageForpassengersForm =
      hotelPackageRoomTypes: []

    packageForpassengersForm.packageId = packageInfo.packageId
    packageForpassengersForm.hotelPackageId = packageInfo.hotelPackageId
    packageForpassengersForm.hotelPackageDateId = hotelPackage.hotelPackageDateId

    createPassengersFormDTO(packageForpassengersForm, packageInfo.logoURL)

  window.VOI.confirmBookInfo = ->
    createBookDTO(packageInfo.logoURL)

  window.VOI.packagePayment = ->
    $('#package-book-information').html ""
    $('.book-confirm-btn').addClass('loading disabled')

    lang = ''
    if drupalSettings.path.currentLanguage != 'en'
      lang = drupalSettings.path.currentLanguage + '/'

    $.ajax
      url: drupalSettings.path.baseUrl + lang + 'package/books'
      method: 'POST'
      data: JSON.stringify(window.VOI.bookingDTO)
      contentType: 'application/json'
      success: (result) ->
        window.VOI.bookId = JSON.parse(result.data)
        dataToShow = """
          <div class="ui success message">
            <div class="header">
              #{Drupal.t('Your Tour Package Booked Successfully')}.
            </div>
          </div>
          <div class="ui tiny message">
            <img class="ui left floated tiny circular image" src="#{packageInfo.logoURL}" style="width: 75px; height: 75px;">
            <div>
              <p>
                <strong>#{Drupal.t('Hotel')}: </strong>#{packageAllHotels} (#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.boardType})
                <span class="ui star rating" data-rating="#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.star}" data-max-rating="5"></span>
              </p>
              <p>
                <strong>#{Drupal.t('Duration')}: </strong>#{window.VOI.bookInfo.duration} #{Drupal.t('Days')} -
                <strong>#{Drupal.t('Start Date')}: </strong>#{makeVestaDate(window.VOI.bookInfo.hotelPackageDate.startDate, pageLang)}
              </p>
              <p>
                <strong>#{Drupal.t('Code')}: </strong>#{window.VOI.bookInfo.packageCode}
              </p>
            </div>
          </div>

          <div class="ui message">
            <h3 class="ui header">#{Drupal.t('Passengers')}</h3>
        """
        i = 0
        for passenger in window.VOI.bookingDTO.passengers
          i++
          dataToShow += """
            <div><strong>#{Drupal.t('Passenger')} #{i}: </strong>#{passenger.firstName} #{passenger.surName}</div>
          """

        dataToShow += """
            <div class="ui divider"></div>
            <h3 class="ui header">#{Drupal.t('Contact Info (Leader)')}</h3>
            <div>#{window.VOI.bookingDTO.contactInfo.firstName} #{window.VOI.bookingDTO.contactInfo.surName} - #{window.VOI.bookingDTO.contactInfo.email} - #{window.VOI.bookingDTO.contactInfo.mobile}</div>
          </div>
        """
        $('#package-book-information').append(dataToShow)
        $('.ui.rating').rating('disable', true)
        $('.package-book-result').modal(autofocus: false, closable: false, observeChanges: true).modal 'show'
        setTimeout (->
          $('.book-confirm-btn').removeClass('loading disabled')
        ), 3000


      error: (errorLog) ->
        console.log (errorLog)
        $('.ui.message-error').remove()
        setTimeout (->
            $('#package-book-Confirmation').prepend """
            <div class="ui negative message message-error">
              <i class="close icon"></i>
              <div class="header">
                #{Drupal.t('Your Book Request Has Encountered a Problem')}!
              </div>
              <p>#{Drupal.t('Please Try Again')}.</p>
            </div>
          """
            $('.ui.message-error .close').on 'click', ->
              $('.ui.message-error').closest('.message-error').transition 'fade'
            $('.book-confirm-agree').attr 'checked', false
            $('.book-confirm-btn').removeClass 'loading'
          ), 1000

  window.VOI.goToBank = ->
    $('.go-to-bank-btn').addClass('loading disabled')
    lang = ''
    if drupalSettings.path.currentLanguage != 'en'
      lang = '/' + drupalSettings.path.currentLanguage
    setTimeout (->
      window.location.href = lang + '/package/pay/' + window.VOI.bookId
    ), 2000


  addPassengerIcon = (passenger) ->
    r = """
      <span class="passenger-icon">
    """
    if passenger is 'female'
      r += '<i class="male icon"></i>'
    r += """
        <i class="#{passenger} icon"></i>
      </span>
    """
    return r


  $('#choose-package-rooms').html ""
  $('.check-availability-btn').removeClass 'loading disabled'
  $('#package-choose-room-package-info').html ""
  $('.package-total-section .total-passengers span').html 0
  $('.package-total-section .total-rooms span').html 0
  $('.package-total-section').css 'display', 'none'
  $('.check-availability-btn').addClass('disabled')
  $('#package-book-Confirmation').html ""

  packageAllHotels = []
  for hotel in hotelPackage.hotels
    packageAllHotels.push(hotel.name)
  $('#package-choose-room-package-info').append """
    <div class="ui tiny message">
      <img class="ui left floated tiny circular image" src="#{packageInfo.logoURL}" style="width: 75px; height: 75px;">
      <div>
        <p>
          <strong>#{packageInfo.name}</strong> -
          <strong>#{Drupal.t('Hotel')}: </strong>#{packageAllHotels} (#{hotelPackage.boardType})<span class="ui star rating" data-rating="#{hotelPackage.star}" data-max-rating="5"></span>
        </p>
        <p>
          <strong>#{Drupal.t('Duration')}: </strong>#{packageInfo.duration} #{Drupal.t('Days')} -
          <strong>#{Drupal.t('Start Date')}: </strong>#{makeVestaDate(packageInfo.startDate, pageLang)}
        </p>
        <p>
          <strong>#{Drupal.t('Code')}: </strong>#{packageInfo.code}
        </p>
      </div>
    </div>
    """


  for room in hotelPackage.hotelPackageRoomTypes
    if room.price > 0
      $('#choose-package-rooms').append """
        <tr class="choose-package-room-row" room-capacity="#{room.roomType.capacity}" is-room="#{room.roomType.room}" room-id="#{room.id}">
          <td class="ui center aligned">
            <div>#{room.roomType.name}</div>
          </td>
          <td class="ui center aligned rooms-nom">
            <div class="ui mini buttons add-minus">
              <button min-value="0" type='button' class="ui button decrease-passenger"><i class="minus icon red"></i></button>
              <div class="between-btn">0</div>
              <button max-value="10" type='button' class="ui button increase-passenger"><i class="plus icon green"></i></button>
            </div>
          </td>
          <td class="ui passengers-field-container">
            <span class="passengers-field pr10">0</span>
          </td>
        </tr>
        """

  $('.decrease-passenger').on 'click', (target)->
    selectedButton = $(target.currentTarget)
    roomCounter = selectedButton.parents('.choose-package-room-row').find('.between-btn')
    roomCapacity = selectedButton.parents('.choose-package-room-row').attr('room-capacity')
    counter = parseInt roomCounter.html(), 10
    minValue = selectedButton.attr('min-value')
    passengersField = selectedButton.parents('.choose-package-room-row').find('.passengers-field-container')
    if counter > minValue
      counter--
      passengersField.find('span.passenger-icon:last-child').remove()
    roomCounter.html counter
    passengersField.find('.passengers-field').html counter * roomCapacity
    calculateTotal()


  $('.increase-passenger').on 'click', (target) ->
    selectedButton = $(target.currentTarget)
    roomCounter = selectedButton.parents('.choose-package-room-row').find('.between-btn')
    roomCapacity = parseInt(selectedButton.parents('.choose-package-room-row').attr('room-capacity'), 10)
    isRoom = selectedButton.parents('.choose-package-room-row').attr('is-room') == 'true'
    counter = parseInt roomCounter.html(), 10
    maxValue = selectedButton.attr('max-value')
    passengersField = selectedButton.parents('.choose-package-room-row').find('.passengers-field-container')
    if counter < maxValue
      counter++
      if isRoom and roomCapacity is 2
        passengersField.append(addPassengerIcon('female'))
      else if isRoom and roomCapacity is 1
        passengersField.append(addPassengerIcon('male'))
      else if isRoom and roomCapacity is 4
        passengersField.append(addPassengerIcon('users'))
      else if !isRoom and roomCapacity is 1
        passengersField.append(addPassengerIcon('child'))

    roomCounter.html counter
    passengersField.find('.passengers-field').html counter * roomCapacity
    calculateTotal()

  $('.package-choose-room').modal 'attach events', '.check-availability-result .go-back-btn'
  $('.check-availability-result').modal 'attach events', '.passengers-for-book .go-back-btn'
  $('.passengers-for-book').modal 'attach events', '.package-book-confirm .go-back-btn'

  $('.ui.modal.package-choose-room').modal(autofocus: false, closable: false, observeChanges: true).modal 'show'
  $('.ui.rating').rating('disable', true)

calculateTotal = ->
  totalPassengers = $('#choose-package-rooms .choose-package-room-row .passengers-field')
  sumPassengers = 0
  for passenger in totalPassengers
    sumPassengers = sumPassengers + parseInt $(passenger).html(), 10
  $('.package-total-section .total-passengers span').html sumPassengers

  totalRooms = $('#choose-package-rooms .choose-package-room-row')
  sumRooms = 0
  for room in totalRooms
    if $(room).attr('is-room') == 'true'
      sumRooms = sumRooms + parseInt $(room).find('.between-btn').html(), 10
    $('.package-total-section .total-rooms span').html sumRooms
  if parseInt($('.package-total-section .total-passengers span').html(), 10) == 0 && parseInt($('.package-total-section .total-rooms span').html(), 10) == 0
    $('.package-total-section').css 'display', 'none'
  else
    $('.package-total-section').css 'display', 'table-row-group'
  if sumRooms > 0
    $('.check-availability-btn').removeClass('disabled')
  else if sumRooms == 0
    $('.check-availability-btn').addClass('disabled')


createPackageDTO = (packageForCheck, logoURL) ->
  $('#package-check-availability-info').html ""
  $('.check-availability-btn').addClass 'loading disabled'

  lang = ''
  if drupalSettings.path.currentLanguage != 'en'
    lang = drupalSettings.path.currentLanguage + '/'

  $.ajax
    url: drupalSettings.path.baseUrl + lang + 'package/checkAvailability'
    method: 'POST'
    data: JSON.stringify(packageForCheck)
    contentType: 'application/json'
    success: (result) ->
      window.VOI.bookInfo = result.tourPackage

      packageAllHotels = []
      for hotel in window.VOI.bookInfo.hotelPackageDate.hotelPackage.hotels
        packageAllHotels.push(hotel.name)
      dataToShow = """
        <div class="ui tiny message">
          <img class="ui left floated tiny circular image" src="#{logoURL}" style="width: 75px; height: 75px;">
          <div>
            <p>
              <strong>#{Drupal.t('Hotel')}: </strong>#{packageAllHotels} (#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.boardType})
              <span class="ui star rating" data-rating="#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.star}" data-max-rating="5"></span>
            </p>
            <p>
              <strong>#{Drupal.t('Duration')}: </strong>#{window.VOI.bookInfo.duration} #{Drupal.t('Days')} -
              <strong>#{Drupal.t('Start Date')}: </strong>#{makeVestaDate(window.VOI.bookInfo.hotelPackageDate.startDate, pageLang)}
            </p>
            <p>
              <strong>#{Drupal.t('Code')}: </strong>#{window.VOI.bookInfo.packageCode}
            </p>
          </div>
        </div>

        <div class="pt40">
          <table class="ui celled table">
            <thead>
              <tr>
                <th>#{Drupal.t('Passengers')}</th>
                <th>#{Drupal.t('Quantity')}</th>
                <th>#{Drupal.t('Price')}</th>
              </tr>
            </thead>
            <tbody>
      """
      totalPrice = 0
      totalPassengers = 0
      for passenger in window.VOI.bookInfo.hotelPackageDate.passengers
        if passenger.currency != null
          currency = passenger.currency

      for passenger in window.VOI.bookInfo.hotelPackageDate.passengers
        totalPrice += passenger.price
        window.VOI.bookInfo.totalPrice = totalPrice
        totalPassengers += passenger.numberOfPassenger
        if passenger.numberOfPassenger != 0
          dataToShow += """
            <tr>
              <td class="seven wide"><strong>#{passenger.passengerType}</strong></td>
              <td class="three wide"><strong>#{passenger.numberOfPassenger}</strong></td>
              <td class="six wide"><strong><span class="price-cell">#{passenger.price}</span> <span>#{Drupal.t(currency)}</span></strong></td>
            </tr>
          """
      dataToShow += """
            </tbody>
            <tfoot class="modal-table-footer">
              <tr>
                <th style="font-size: 21px"><strong>#{Drupal.t('Total')}</strong></th>
                <th style="font-size: 21px"><strong>#{totalPassengers}</strong></th>
                <th style="font-size: 21px"><strong><span class="price-cell">#{totalPrice}</span> <span>#{Drupal.t(currency)}</span></strong></th>
              </tr>
            </tfoot>
          </table>
        </div>
      """

      $('#package-check-availability-info').append(dataToShow)
      $('.ui.rating').rating('disable', true)
      $('span.price-cell').commaSeparator()
      $('.modal.check-availability-result').modal(autofocus: false, closable: false, observeChanges: true).modal 'show'
      $('.check-availability-btn').removeClass 'loading disabled'

    error: () ->
      $('.ui.message-error').remove()
      setTimeout (->
        $('#package-choose-room-package-info').prepend """
          <div class="ui negative message message-error">
            <i class="close icon"></i>
            <div class="header">
              #{Drupal.t('No Package Available')}!
            </div>
            <p>#{Drupal.t('Please Try Again')}.</p>
          </div>
        """
        $('.ui.message-error .close').on 'click', ->
          $('.ui.message-error').closest('.message-error').transition 'fade'
        $('.check-availability-btn').removeClass 'loading disabled'
      ), 1000

createPassengersFormDTO = (packageForpassengersForm, logoURL) ->
  $('#passengers-form-for-book').html ""
  packageAllHotels = []
  for hotel in window.VOI.bookInfo.hotelPackageDate.hotelPackage.hotels
    packageAllHotels.push(hotel.name)

  dataToShow = """
    <div class="ui tiny message">
      <img class="ui left floated tiny circular image" src="#{logoURL}" style="width: 75px; height: 75px;">
      <div>
        <p>
          <strong>#{Drupal.t('Hotel')}: </strong>#{packageAllHotels} (#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.boardType})
          <span class="ui star rating" data-rating="#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.star}" data-max-rating="5"></span>
        </p>
        <p>
          <strong>#{Drupal.t('Duration')}: </strong>#{window.VOI.bookInfo.duration} #{Drupal.t('Days')} -
          <strong>#{Drupal.t('Start Date')}: </strong>#{makeVestaDate(window.VOI.bookInfo.hotelPackageDate.startDate, pageLang)}
        </p>
        <p>
          <strong>#{Drupal.t('Code')}: </strong>#{window.VOI.bookInfo.packageCode}
        </p>
      </div>
    </div>


    <form class="ui form" id="passengers-form-for-book">
      <div class="ui segment">
        <h3 class="ui header">#{Drupal.t('Passengers Informations')}</h3>
    """
  passengerCount = 0
  for passenger in window.VOI.bookInfo.hotelPackageDate.passengers
    i = 0
    while i < passenger.numberOfPassenger
      i++
      passengerCount++
      dataToShow += """
        <div class="field">
          <label>#{Drupal.t('Passenger')} #{passengerCount}</label>
          <div class="two fields">
            <div class="field">
              <div class="ui corner labeled input">
                <input type="text" placeholder="#{Drupal.t('First Name')}" id="passenger-#{passengerCount}-name" name="firstName-#{passengerCount}-field">
                <div class="ui corner label">
                  <i class="asterisk icon"></i>
                </div>
              </div>
            </div>
            <div class="field">
              <div class="ui corner labeled input">
                <input type="text" placeholder="#{Drupal.t('Last Name')}" id="passenger-#{passengerCount}-surname" name="surname-#{passengerCount}-field">
                <div class="ui corner label">
                  <i class="asterisk icon"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      """

  dataToShow += """
    </div>
    <div class="ui segment">
      <h3 class="ui header">#{Drupal.t('Leader Information')}</h3>
      <div class="two fields">
        <div class="field">
          <div class="ui corner labeled input">
            <input type="text" placeholder="#{Drupal.t('First Name')}" id="leader-name">
            <div class="ui corner label">
              <i class="asterisk icon"></i>
            </div>
          </div>
        </div>
        <div class="field">
          <div class="ui corner labeled input">
            <input type="text" placeholder="#{Drupal.t('Last Name')}" id="leader-surname">
            <div class="ui corner label">
              <i class="asterisk icon"></i>
            </div>
          </div>
        </div>
      </div>
      <div class="two fields">
        <div class="field">
          <div class="ui corner labeled input">
            <input type="text" placeholder="#{Drupal.t('Email')}" id="leader-email">
            <div class="ui popup custom">
              <div class="ui label olive card">
                <div class="content">
                    <div class="header">#{Drupal.t('Pay Attention')}!</div>
                    <div class="meta">#{Drupal.t('This Email will be Taken for Your Username')}.</div>
                  </div>
              </div>
            </div>
            <div class="ui corner label">
              <i class="asterisk icon"></i>
            </div>
          </div>
        </div>
        <div class="field">
          <div class="ui corner labeled input">
            <input type="text" placeholder="#{Drupal.t('Mobile')}" id="leader-mobile">
            <div class="ui corner label">
              <i class="asterisk icon"></i>
            </div>
          </div>
        </div>
      </div>
    </div>




    </form>
    """

  validationConfig = {
    on: 'blur',
    fields: {
      'leader-name': ['maxLength[100]', 'empty'],
      'leader-surname': ['maxLength[100]', 'empty'],
      'leader-email': ['email', 'empty']
      'leader-mobile': ['number', 'empty']
    }
  };

  i = 1
  while i <= passengerCount
    validationConfig.fields["firstName-"+i+"-field"] = ['maxLength[30]', 'empty']
    validationConfig.fields["surname-"+i+"-field"] = ['maxLength[30]', 'empty']
    i++



  $('#passengers-form-for-book').append(dataToShow)
  $('.ui.rating').rating('disable', true)
  $('.modal.passengers-for-book').modal(autofocus: false, closable: false, observeChanges: true).modal 'show'

  $('#passengers-form-for-book').form(validationConfig);


createBookDTO = (logoURL) ->
  console.log window.VOI.bookInfo.hotelPackageDate.passengers
  if $("#passengers-form-for-book").form("validate form")
    $('.modal.package-book-confirm').modal(autofocus: false, closable: false, observeChanges: true).modal 'show'
    $('.book-confirm-btn').addClass('disabled')
    $('#package-book-Confirmation').html ""
    window.VOI.bookingDTO =
      passengers: []
    passengerCount = 0
    for passenger in window.VOI.bookInfo.hotelPackageDate.passengers
      i = 0
      while i < passenger.numberOfPassenger
        i++
        passengerCount++
        window.VOI.bookingDTO.passengers.push
          firstName: $('#passenger-'+passengerCount+'-name').val()
          surName: $('#passenger-'+passengerCount+'-surname').val()
    window.VOI.bookingDTO.contactInfo =
      firstName: $('#leader-name').val()
      surName: $('#leader-surname').val()
      email: $('#leader-email').val()
      mobile: $('#leader-mobile').val()
      country: {
        id: 1
      }
    window.VOI.bookingDTO.hotelPackageDateId = window.VOI.bookInfo.hotelPackageDate.hotelPackageDateId
    window.VOI.bookingDTO.hotelPackageId = window.VOI.bookInfo.hotelPackageDate.hotelPackage.hotelPackageId
    window.VOI.bookingDTO.hotelPackageRooms = window.VOI.bookInfo.hotelPackageDate.hotelPackage.hotelPackageRoomTypes
    window.VOI.bookingDTO.packageId = window.VOI.bookInfo.packageId

    packageAllHotels = []
    for hotel in window.VOI.bookInfo.hotelPackageDate.hotelPackage.hotels
      packageAllHotels.push(hotel.name)

    dataToShow = """
      <div class="ui tiny message">
        <img class="ui left floated tiny circular image" src="#{logoURL}" style="width: 75px; height: 75px;">
        <div>
          <p>
            <strong>#{Drupal.t('Hotel')}: </strong>#{packageAllHotels} (#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.boardType})
            <span class="ui star rating" data-rating="#{window.VOI.bookInfo.hotelPackageDate.hotelPackage.star}" data-max-rating="5"></span>
          </p>
          <p>
            <strong>#{Drupal.t('Duration')}: </strong>#{window.VOI.bookInfo.duration} #{Drupal.t('Days')} -
            <strong>#{Drupal.t('Start Date')}: </strong>#{makeVestaDate(window.VOI.bookInfo.hotelPackageDate.startDate, pageLang)}
          </p>
          <p>
            <strong>#{Drupal.t('Code')}: </strong>#{window.VOI.bookInfo.packageCode}
          </p>
        </div>
      </div>

      <div class="ui segment">
        <span class="ui second right ribbon label">#{Drupal.t('Total Price')}: <span class="price-cell">#{window.VOI.bookInfo.totalPrice}</span> <span>#{Drupal.t(currency)}</span></span>
        <h3 class="ui header">#{Drupal.t('Passengers')}</h3>
    """
    i = 0
    for passenger in window.VOI.bookingDTO.passengers
      i++
      dataToShow += """
        <div><strong>#{Drupal.t('Passenger')} #{i}: </strong>#{passenger.firstName} #{passenger.surName}</div>
      """

    dataToShow += """
        <div class="ui divider"></div>
        <h3 class="ui header">#{Drupal.t('Contact Info (Leader)')}</h3>
        <div>#{window.VOI.bookingDTO.contactInfo.firstName} #{window.VOI.bookingDTO.contactInfo.surName} - #{window.VOI.bookingDTO.contactInfo.email} - #{window.VOI.bookingDTO.contactInfo.mobile}</div>

        <div class="ui divider"></div>
        <h3 class="ui header">#{Drupal.t('Cancellation Policy')}</h3>
        #{window.VOI.bookInfo.cancellationPolicy}
        <div class="ui divider"></div>
        <div class="required inline field agreement-field">
          <div class="ui checkbox">
            <input type="checkbox" class="hidden book-confirm-agree">
            <label>#{Drupal.t('I Agree')}</label>
          </div>
        </div>
      </div>
    """

    $('#package-book-Confirmation').append(dataToShow)
    $('.ui.rating').rating('disable', true)
    $('span.price-cell').commaSeparator()
    $('.ui.checkbox').checkbox()

    $('.package-book-confirm .book-confirm-agree').on 'change', ->
      if this.checked
        $('.package-book-confirm .book-confirm-btn').removeClass('disabled')
      else
        $('.package-book-confirm .book-confirm-btn').addClass('disabled')