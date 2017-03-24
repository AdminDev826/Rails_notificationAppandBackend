$(document).ready(function() {
  var options = {
    valueNames: [ 'name' ]
  };

  var userList = new List('businesses', options);

  $('#search-in-navbar-mobile-perks').keyup(function(){
    userList.search($(this).val());
  });
});
