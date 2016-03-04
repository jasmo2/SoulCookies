var readyWindow;



readyWindow = function() {
    $(window).on("load", function() {
        if (window.location.hash != null && window.location.hash != '') {
            $(".overlay").hide();
            setInterval(function(self){

                var hash;
                hash = self.hash;
                $('html, body').animate({
                    scrollTop: $(self.hash).offset().top
                }, 300, function() {
                    window.location.hash = hash;
                });
            }(window.location), 8000);

        }
    });

};

$(document).on('ready page:load', readyWindow);
