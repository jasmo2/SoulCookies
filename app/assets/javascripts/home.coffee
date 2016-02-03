ready = undefined

ready = ->
# initialize bxslider
  $('.bxslider').bxSlider()
  return

$(document).ready ready
$(document).on 'page:load', ready
;