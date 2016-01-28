ready = ->
  `var loginFb = $("#login-fb"),
       uid ,
       accessToken`
  fetchUserInformation = (me,urlPath)->
    $.ajax(
      url: urlPath,
      data: me,
      method: "POST")
    .success (response)->
      loginFb.hide()
      toTrim = $("#customer-user").html(response)
      $("#customer-user").html(toTrim.children("#form-container")[0].innerHTML)
    .fail (err)->
      console.log("error "+err)
#    $("#order_phone_number").val me.mobile_number
  $(document).ready ->
    $.ajaxSetup cache: true
    $.getScript "//connect.facebook.net/en_US/all.js", ->
      FB.init
        appId: "182897058733210"
        version: "v2.5" # or v2.0, v2.1, v2.2, v2.3
    statusChangeCallback = (response) ->
      console.log "statusChangeCallback"
      console.log response
      # The response object is returned with a status field that lets the
      # app know the current login status of the person.
      # Full docs on the response object can be found in the documentation
      # for FB.getLoginStatus().
        # Logged into your app and Facebook.
      if response and response.status is "connected"
        testAPI()
      else if response.status is "not_authorized"
        # The person is logged into Facebook, but not your app.
        alert "Please log " + "into this app."
      else
        # The person is not logged into Facebook, so we're not sure if
        # they are logged into this app or not.
        alert "Please log " + "into Facebook."


    checkLoginStatus = (response, urlPath) ->
      if response and response.status is "connected"
        console.log('Welcome!  Fetching your information.... ')
        uid = response.authResponse.userID
        accessToken = response.authResponse.accessToken
        FB.api "/me", "GET",
          fields: "id,first_name,last_name,email"
        , (response) ->
          fetchUserInformation response,urlPath
      else
        console.log('User cancelled login or did not fully authorize.')

    loginFb.click (e)->
      e.preventDefault()
      urlPath = $(this).attr("href")
      FB.login ((response)-> checkLoginStatus(response,urlPath) ), scope: "email, user_likes"




$(document).ready(ready)
$(document).on('page:load', ready)
