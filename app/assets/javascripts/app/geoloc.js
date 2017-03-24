function setRoutePathFromLocation() {
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(getPosition, geolocErrors, { maximumAge: 0, enableHighAccuracy: true});
  }
}

function getGeolocation() {
  if(navigator.geolocation) {
    navigator.geolocation.watchPosition(watchPosition, geolocErrors, { maximumAge: 0, enableHighAccuracy: true});
  }
}

function watchPosition(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  document.cookie = "coordinates=" + lat + "&" + lng + ";";
}

function getPosition(position) {
  var lat = position.coords.latitude
  var lng = position.coords.longitude
  buildUrl("#link-map", lat, lng);
  buildUrl("#link-itinerary", lat, lng);
}

function buildUrl(selector, lat, lng) {
  var locale = $(selector).data("locale");
  var destination = $(selector).data("destination");
  var linkToNavigation = $(selector).attr("href");

  //saddr=latitude,longitude&daddr=latitude,longitude&hl=#{I18n.locale}
  linkToNavigation = linkToNavigation + "?saddr=" + lat + "," + lng
  + "&daddr=" + destination.latitude + "," + destination.longitude
  + "&hl=" + locale;

  //$("loader").hide();
  $(selector).removeAttr('disabled');
  $(selector).attr("href", linkToNavigation);
}

function geolocErrors(error) {
  var info = "";
  switch(error.code) {
    case error.TIMEOUT:
      info += "Timeout !";
    break;
    case error.PERMISSION_DENIED:
      info += "Avez-vous autorisé la géolocalisation ?";
    break;
    case error.POSITION_UNAVAILABLE:
      info += "La position n’a pu être déterminée";
    break;
    case error.UNKNOWN_ERROR:
      info += "Erreur inconnue";
    break;
  }
  $("#link-map").addClass("unable");
  $('.info-unable').remove();
  $("#link-map").after('<span class="info-unable">' + info + "</span>");
  $("#link-itinerary").addClass("unable");
}
