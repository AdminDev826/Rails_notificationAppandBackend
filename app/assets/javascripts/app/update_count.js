$(document).ready(function() {
  $('#search-dashboard').keyup(function(){
    var elements = $("#business-search-modal-desktop .business-name-desk:visible").length;
    if (elements <= 1) {
      $( ".text-count" ).text( elements + " resultat");
    } else {
      $( ".text-count" ).text( elements + " resultats");
    }
  });
});
