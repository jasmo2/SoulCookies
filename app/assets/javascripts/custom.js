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
  enquire.register("screen and (min-width:991px)", {
    match : function() {
      andrzejdus.parallaxer.Parallaxer.start();
    }
  });
};

$(document).on('ready page:load', ready);

