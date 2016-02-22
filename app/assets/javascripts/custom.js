var ready;
ready = function() {
  // SCROLLSPY
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

  // ADD SLIDEDOWN ANIMATION TO DROPDOWN //
  $('.dropdown').on('show.bs.dropdown', function(e){
    $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
  });

  // ADD SLIDEUP ANIMATION TO DROPDOWN //
  $('.dropdown').on('hide.bs.dropdown', function(e){
    $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
  });

  // COOKIE SLIDER
  $('.bxslider').bxSlider({
    randomStart: true,
    pager: false
  });

  // PARALLAX EFFECTS
  andrzejdus.parallaxer.Parallaxer.start();

  
  
    
};
$(document).ready(ready);
$(document).on('page:load', ready);