var ready;
ready = function() {
  // initialize bxslider
  $('.bxslider').bxSlider();
};
$(document).ready(ready);
$(document).on("page:load", ready);