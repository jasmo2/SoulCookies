# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  $confirmationCustomer = $("#confirmation-customer");
  $directionRadioGroup = $("input[name='addresses']")
  customerUser = document.getElementById("current-customer").value
  $confirmationCustomer.click ->

    direction = directionRadioButton.value for directionRadioButton in $directionRadioGroup when directionRadioButton.checked
    confirmation = {
      "direction": direction,
      "customer": customerUser
    }
    $.ajax(
      beforeSend: `function(xhr) {
          xhr.setRequestHeader(
              'X-CSRF-Token',
              $('meta[name="csrf-token"]').attr('content')
          )
      }`,
      statusCode:
        200: (response)->
          eval(response.responseText)
        500: (err)->
          alert "Ha ocurrido un error cominiquese con nosotros"
      url: '/checkout/confirm',
      contentType: 'application/json',
      dataType: 'json',
      data: JSON.stringify({"confirmation": confirmation}),
      type: 'POST'
    )
    .done (data)->
      console.log "ok: "+data
    .fail (err)->
      console.log(err)



$(document).ready ready
$(document).on 'page:load', ready
