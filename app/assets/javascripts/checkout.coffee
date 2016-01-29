ready = ->
  `var loginFb = $("#login-fb")
       newCustomerUser = $(".customer-user-record"),
       uid= null,
       accessToken = null`
  fillResponse = (response,customerUser,uid)->
    toTrim = customerUser.html(response)
    customerUser.html(toTrim.children("#form-container")[0].innerHTML)
    hidden = $(document.createElement('input')).attr(
      type: 'hidden',
      id: 'customers_user_uid',
      name: "customers_user[uid]",
      value: uid
    )
    customerUser.children("form").append(hidden)
    null
  fetchUserInformation = (me,urlPath,uid)->
    customerUser = $("#customer-user")
    $.ajax(
      url: urlPath,
      data: me,
      dataType: "html",
      method: "POST")
    .success (response)->
      newCustomerUser.hide()
      fillResponse(response,customerUser,uid)
      $('#customer-submit').submit ->
        valuesToSubmit = $(this).serialize()
        console.log(valuesToSubmit)
        $.ajax(
          url: $(this).attr('action'),
          data: valuesToSubmit,
          dataType: "html",
          type: this.method.toUpperCase()
        )
        .success (response)->
          customerUser.hide()
        .fail (err)->
          if err.status == 400
            fillResponse(err.responseText,customerUser,uid)
          console.log("error "+err)
        return false
    .fail (err)->
      console.log("error "+err)
#    $("#order_phone_number").val me.mobile_number
  $(document).ready ->
    $.ajaxSetup cache: true
    $.getScript "//connect.facebook.net/en_US/all.js", ->
      FB.init
        appId: "182897058733210"
        version: "v2.5" # or v2.0, v2.1, v2.2, v2.3

    checkLoginStatus = (response, urlPath) ->
      if response and response.status is "connected"
        console.log('Welcome!  Fetching your information.... ')
        uid = response.authResponse.userID
        accessToken = response.authResponse.accessToken
        FB.api "/me", "GET",
          fields: "id,first_name,last_name,email"
        , (response) ->
          fetchUserInformation response,urlPath,uid
      else
        console.log('User cancelled login or did not fully authorize.')

    loginFb.click (e)->
      e.preventDefault()
      urlPath = $(this).attr("href")
      FB.login ((response)-> checkLoginStatus(response,urlPath) ), scope: "email, user_likes"




$(document).ready(ready)
$(document).on('page:load', ready)
