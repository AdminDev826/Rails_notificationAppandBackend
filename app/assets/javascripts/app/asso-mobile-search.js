$(document).ready(function() {
  var options = {
    valueNames: [ 'name', 'category' ]
  };

  var userList = new List('assos', options);

  $('#search-in-navbar-mobile-assos').keyup(function(){
    userList.search($(this).val());
  });
});
