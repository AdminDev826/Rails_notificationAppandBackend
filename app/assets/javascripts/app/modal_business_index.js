$(document).ready(function() {
  $('#search-in-navbar-mobile').keyup(function(){
      $(".business-search-index-js").removeClass("hidden");
  });
});

$(document).ready(function() {
    $('.business-search-close-button').click(function() {
    $(".business-search-index-js").addClass('hidden');
    });
});

$(document).ready(function() {
    $('.business-search-close-button').click(function() {
      $('#search-in-navbar-mobile').val('');
    });
});
