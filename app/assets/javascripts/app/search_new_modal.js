$(document).ready(function() {
  $(".search-modal-button").click(function() {
  $(".search-modal").toggleClass("hidden");
  });
});

$(document).ready(function() {
  $('.close-search-modal').click(function() {
  $(".search-modal").addClass('hidden');
  });
});

$(document).ready(function(){

  $('.search-modal-button').click(function(event) {
    $('.search-category-overlay').toggleClass('hidden');
  });

  // TOOGLE CATEGORY OVERLAY
  $('.search-category-overlay').click(function(event) {
    $('.search-modal').addClass('hidden');
  });

});

$(document).ready(function() {
  $(".search-modal-button-mobile").click(function() {
  $(".search-input-mobile").toggleClass("hidden");
  });
});
