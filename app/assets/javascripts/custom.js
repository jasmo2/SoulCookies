var ready;
ready = function() {
  // scrollspy
  $('.navbar-nav li a[href^=\'#\']').on('click', function(e) {
    var hash;
    e.preventDefault();
    hash = this.hash;
    $('html, body').animate({
      scrollTop: $(this.hash).offset().top
    }, 300, function() {
      window.location.hash = hash;
    });
  });

  // cookie slider
  $('.bxslider').bxSlider({
    randomStart: true,
    pager: false
  });
    
};
$(document).ready(ready);
$(document).on("page:load", ready);