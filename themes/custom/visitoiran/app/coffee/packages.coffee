$ ->
  $('.ui.dropdown').dropdown()
  $('.ui.accordion').accordion
  $('#hotel-filter .ui.accordion').accordion exclusive: false
  $('.ui.checkbox').checkbox()
  $('.special.cards .image').dimmer on: 'hover'
  $('.tab-menu .menu .item').tab context: 'parent'
  $('.ui.rating').rating('disable', true)
  $('.coupled.modal').modal allowMultiple: false
  $('.menu .item').tab()
  $('.ui.message .close').on 'click', ->
    $(this).closest('.message').transition 'fade'
  return

$('body').delegate '#activation-user-btn', 'click', ->
  $('.login-page .item.register-tab').removeClass('active')
  $('#register-form').parent().removeClass('active')
  $('.login-page .item.activation-tab').addClass('active')
  $('#active-user-form').parent().addClass('active')

$('body').delegate '.ui.form input', 'focus', ->
  if $(this).parent().find('.ui.popup.custom').length > 0
    $(this).popup
      popup : $(this).parent().find('.ui.popup.custom')
      position: 'top right'
      on: 'focus'

$('#resend-activation-btn').click ->
  $('.ui.modal.resend-activation').modal(autofocus: false, closable: false, observeChanges: true).modal 'show'

$('#login-form').submit ->
  $('#login-form .ui.button').addClass('loading disabled')

validationConfig = {
  on: 'blur',
  fields: {
    email: ['maxLength[100]', 'empty'],
    password: ['maxLength[100]', 'empty'],
    confirmPassword: ['maxLength[100]', 'empty'],
    currentPassword: ['maxLength[100]', 'empty'],
    newPassword: ['maxLength[100]', 'empty'],
    activationCode: ['maxLength[300]', 'empty'],
  }
};

$('#login-form').form(validationConfig);
$('#register-form').form(validationConfig);
$('#active-user-form').form(validationConfig);
$('#reset-password-form').form(validationConfig);
$('#set-password-form').form(validationConfig);
$('#change-password-form').form(validationConfig);
$('#resend-activation-form').form(validationConfig);

Vue.filter 'date', (value) ->
  if value
    date = new Date(value)
    gdate = new gregorianCalendar(date.getFullYear(), date.getMonth()+1, date.getDate())
    return gdate.toString('yy/mm/dd')
  value


window.VOI.goToBankGeneral = (c, bookId) ->
  $(c).addClass('loading disabled')
  lang = ''
  if drupalSettings.path.currentLanguage != 'en'
    lang = '/' + drupalSettings.path.currentLanguage
  setTimeout (->
    window.location.href = lang + '/package/pay/' + bookId
  ), 2000

window.VOI.seeVoucher = (c, bookId) ->
  $('#messages-container .custom-messages').html ""
  $(c).addClass('loading disabled')
  $.ajax
    url: drupalSettings.path.baseUrl + "package/voucher/#{bookId}"
    method: 'POST'
    contentType: 'application/json'
    success: (result) ->
      app2 = new Vue(
        el: '#package-voucher'
        data: {
          paymentInfo: result
        },
        computed: {
          cities:  ->
            allCities = []
            currentCity = ''
            for itinerary in result.itineraries
              if itinerary.city.name != currentCity
                currentCity = itinerary.city.name
                allCities.push currentCity
            return allCities
        },
        delimiters: [
          '${'
          '}'
        ])

      $('#package-voucher').modal(
        onHide: ->
          $(c).removeClass('loading disabled')
      ).modal('show')
      $('.ui.rating').rating('disable', true)
      $('span.price-cell').commaSeparator()

    error: (errorLog) ->
      setCustomMessage('An Error Has Occurred!', 'Please try Later.', 'negative')
      $(c).removeClass('loading disabled')

$('#register-form').submit ->
  $('#messages-container .custom-messages').html ""
  userEmail = $('#register-form').find('input[name=email]').val()
  userPassword = $('#register-form').find('input[name=password]').val()
  userConfirmPassword = $('#register-form').find('input[name=confirmPassword]').val()

  dateToRegister = {
    "userName": userEmail,
    "password": userPassword,
    "confirmPassword": userConfirmPassword,
  }

  if !userEmail or !userPassword or !userConfirmPassword

    setCustomMessage('Some fields can not be empty!', 'Please fill them.', 'negative')

  else if userPassword != userConfirmPassword
    setCustomMessage('Your passwords are not same!', 'Please try again.', 'negative')
  else
    $('#register-form .ui.button').addClass('loading disabled')
    $.ajax
      url: drupalSettings.path.baseUrl + 'package/user/register'
      method: 'POST'
      data: JSON.stringify(dateToRegister)
      contentType: 'application/json'
      success: (result) ->
        setCustomMessage('Your registration request has sent successfully.', 'Please check your email and active your username.', 'success')

        $('.login-page .item.register-tab').removeClass('active')
        $('#register-form').parent().removeClass('active')
        $('.login-page .item.activation-tab').addClass('active')
        $('#active-user-form').parent().addClass('active')

        $('#register-form .ui.button').removeClass('loading disabled')
      error: (errorLog) ->
        if errorLog.responseJSON.errorCode == 6022
          setCustomMessage('Username already exists!', 'Please <a id="activation-user-btn">Active</a> your username or <a href="http://www.visitoiran.com/package/home">Log In</a>.', 'warning')
        else
          setCustomMessage('There is an error in your registration request!', 'Please try again.', 'negative')
        $('#register-form .ui.button').removeClass('loading disabled')
  return false

$('#resend-activation-form').submit ->
  userEmail = $('#resend-activation-form').find('input[name=email]').val()
  if !userEmail
    setCustomMessage('Some fields can not be empty!', 'Please fill them.', 'negative')
  else
    $('#resend-activation-form .ui.button.primary').addClass('loading disabled')
    $.ajax
      url: drupalSettings.path.baseUrl + 'package/user/resendActivation'
      method: 'POST'
      data: userEmail
      contentType: 'application/json'
      success: (result) ->
        $('.ui.modal.resend-activation').modal 'hide'
        setCustomMessage('Activation Email Resend to Your Email!', 'Please Check your Email.', 'success')
        $('#resend-activation-form .ui.button.primary').removeClass('loading disabled')
      error: (errorLog) ->
        $('.ui.modal.resend-activation').modal 'hide'
        errorMessage = errorLog.responseJSON.data
        setCustomMessage('Error in Resend Activation Email!', errorMessage, 'negative')
        $('#resend-activation-form .ui.button.primary').removeClass('loading disabled')
  return false

$('#active-user-form').submit ->
  $('#messages-container .custom-messages').html ""
  userEmail = $('#active-user-form').find('input[name=email]').val()
  activationCode = $('#active-user-form').find('input[name=activationCode]').val()

  dataToActive = {
    "code": activationCode,
    "user": userEmail
  }

  if !userEmail or !activationCode
    setCustomMessage('Some fields can not be empty!', 'Please fill them.', 'negative')
  else
    $('#active-user-form .ui.button').addClass('loading disabled')
    $.ajax
      url: drupalSettings.path.baseUrl + 'package/user/activate'
      method: 'POST'
      data: JSON.stringify(dataToActive)
      contentType: 'application/json'
      success: (result) ->
        setCustomMessage('Your Activation has done Successfully.', 'Now you can <a href="http://www.visitoiran.com/package/home">Log In</a> to System', 'success')
        $('#active-user-form .ui.button').removeClass('loading disabled')
      error: (errorLog) ->
        setCustomMessage('Your Request for Active Your User not been Successfully!', 'Please try again.', 'negative')
        $('#active-user-form .ui.button').removeClass('loading disabled')
  return false

$('#reset-password-form').submit ->
  $('#messages-container .custom-messages').html ""
  userEmailToReset = $('#reset-password-form').find('input[name=email]').val()

  dataToResetRequest = {
    userName: userEmailToReset,
    applicationName: 'PMS'
  }

  if !userEmailToReset
    setCustomMessage('Some fields can not be empty!', 'Please fill them.', 'negative')
  else
    $('#reset-password-form .ui.button').addClass('loading disabled')
    $.ajax
      url: drupalSettings.path.baseUrl + 'package/user/resetPasswordRequest'
      method: 'POST'
      data: JSON.stringify(dataToResetRequest)
      contentType: 'application/json'
      success: (result) ->
        setCustomMessage('Your reset password request has sent successfully.', 'Please check your email for reset password email.', 'success')
        $('#reset-password-form .ui.button').removeClass('loading disabled')
      error: (errorLog) ->
        setCustomMessage('Your reset password request has not sent successfully!', 'Please try again.', 'negative')
        $('#reset-password-form .ui.button').removeClass('loading disabled')
  return false

$('#set-password-form').submit ->
  $('#messages-container .custom-messages').html ""
  userNewPassword = $('#set-password-form').find('input[name=newPassword]').val()
  userConfirmPassword = $('#set-password-form').find('input[name=confirmPassword]').val()
  uuid = $('#set-password-form').find('input[name=uuid]').val()

  dateToSetPassword = {
    "id": uuid,
    "password": userNewPassword
  }

  if !userNewPassword or !userConfirmPassword
    setCustomMessage('Some fields can not be empty!', 'Please fill them.', 'negative')
  else if userNewPassword != userConfirmPassword
    setCustomMessage('Your new password and confirm password are not same!', 'Please try again.', 'negative')
  else
    $('#set-password-form .ui.button').addClass('loading disabled')
    $.ajax
      url: drupalSettings.path.baseUrl + 'package/user/resetPassword'
      method: 'POST'
      data: JSON.stringify(dateToSetPassword)
      contentType: 'application/json'
      success: (result) ->
        setCustomMessage('Your new password has set successfully.', 'Now you can <a href="http://www.visitoiran.com/package/home">Log In</a> to the system.', 'success')
        $('#set-password-form .ui.button').removeClass('loading disabled')
      error: (errorLog) ->
        setCustomMessage('An error has occurred!', 'Please try again.', 'negative')
        $('#set-password-form .ui.button').removeClass('loading disabled')

  return false

$('#change-password-form').submit ->
  $('#messages-container .custom-messages').html ""
  username = $('#change-password-form').find('input[name=username]').val()
  userCurrentPassword = $('#change-password-form').find('input[name=currentPassword]').val()
  userNewPassword = $('#change-password-form').find('input[name=newPassword]').val()
  userConfirmPassword = $('#change-password-form').find('input[name=confirmPassword]').val()

  dateToChangePassword = {
    "user": username,
    "oldPassword": userCurrentPassword,
    "newPassword": userNewPassword
  }

  if !userCurrentPassword or !userNewPassword or !userConfirmPassword
    setCustomMessage('Some fields can not be empty!', 'Please fill them.', 'negative')
  else if userNewPassword != userConfirmPassword
    setCustomMessage('Your new password and confirm password are not same!', 'Please try again.', 'negative')
  else
    $('#change-password-form .ui.button').addClass('loading disabled')
    $.ajax
      url: drupalSettings.path.baseUrl + 'package/user/changePassword'
      method: 'POST'
      data: JSON.stringify(dateToChangePassword)
      contentType: 'application/json'
      success: (result) ->
        setCustomMessage('Your reset password request has sent successfully.', 'Please check your email for reset password email.', 'success')
        $('#change-password-form .ui.button').removeClass('loading disabled')
      error: (errorLog) ->
        setCustomMessage('Your reset password request has not sent successfully!', 'Please try again.', 'negative')
        $('#change-password-form .ui.button').removeClass('loading disabled')
  return false


$('#update-user-info-form').submit ->
  $('#messages-container .custom-messages').html ""
  username = $('#update-user-info-form').find('input[name=username]').val()
  useMobile = $('#update-user-info-form').find('input[name=mobile]').val()
  userTitle = $('#update-user-info-form').find('select[name=title]').val()
  userGender = $('#update-user-info-form').find('select[name=gender]').val()
  userFirstName = $('#update-user-info-form').find('input[name=firstName]').val()
  userSurname = $('#update-user-info-form').find('input[name=surname]').val()

  dataToUpadateUserInfo = {
    "userName": username,
    "msisdn": useMobile,
    "title": userTitle,
    "gender": userGender,
    "firstName": userFirstName,
    "surname": userSurname,
  }

  $('#update-user-info-form .ui.button').addClass('loading disabled')
  $.ajax
    url: drupalSettings.path.baseUrl + 'package/user/update'
    method: 'POST'
    data: JSON.stringify(dataToUpadateUserInfo)
    contentType: 'application/json'
    success: (result) ->
      setCustomMessage('Information Changed', 'Your Information Changed Successfully.', 'success')
      $('#update-user-info-form .ui.button').removeClass('loading disabled')
    error: (errorLog) ->
      setCustomMessage('An error has occurred!', 'Please Try Again.', 'negative')
      $('#update-user-info-form .ui.button').removeClass('loading disabled')
  return false