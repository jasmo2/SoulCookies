var ready;
ready = function() {
 // hide spinner and layout
  $(".overlay").hide();


  // show spinner on AJAX start
  $(document).ajaxStart(function(){
    $(".overlay").show();
  });

  // hide spinner on AJAX stop
  $(document).ajaxStop(function(){
    $(".overlay").hide();
  });
};
  $(document).on('ready page:load', ready);

  // with turbolinks
  $(document).on("page:fetch", function(){
    $(".overlay").show();
  });

  $(document).on("page:receive", function(){
    $(".overlay").hide();
  });