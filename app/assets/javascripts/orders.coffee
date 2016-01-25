# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.coffee.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  updateOrderItemsFromRemote = (data)->
    if data.status == 'complete'
      if data.redirect?
        window.location.replace(data.redirect)
      else if data.items?
        $('table.orderItems').replaceWith(data.items)
    else if data.status == 'error'
      alert data.message

  ajaxLink = (successMethod)->
    $.ajax
      url: $(this).attr('href')
      type: $(this).data('method')
      dataType: 'json'
      success: successMethod
    false


  $('body').on 'click', 'a.ajax',
    -> ajaxLink.call(this, updateOrderItemsFromRemote)

  null
