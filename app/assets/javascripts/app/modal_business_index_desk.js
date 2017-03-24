$(document).ready(function() {
  $('#search-dashboard').keyup(function(){
      $(".business-search-index-js-desk").removeClass("hidden");
  });
});

$(document).ready(function() {
    $('.business-search-close-button-desk').click(function() {
    $(".business-search-index-js-desk").addClass('hidden');
    });
});

$(document).ready(function() {
    $('.business-search-close-button-desk').click(function() {
      $('#search-dashboard').val('');
    });
});

$(document).ready(function() {
    $('.business-search-close-button-desk').click(function() {
      $(".search-modal").addClass('hidden');
    });
});

$(document).ready(function() {
    $('.business-search-close-button-desk').click(function() {
      $(".search-category-overlay").addClass('hidden');
    });
});

$(document).ready(function() {
    var options = {
      valueNames: [ 'business-name-desk' ]
    };

    var userList = new List('business-search-modal-desktop', options);

    $('#search-dashboard').keyup(function(){
      userList.search($(this).val());
    });
});
