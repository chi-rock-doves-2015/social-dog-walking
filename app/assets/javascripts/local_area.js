$(document).ready(function(){
  $("#show-local-area").click(function() {
    html5Geolocation(sendCurrentPositionAndGoToLocalAreaRoute);
  });
});

function sendCurrentPositionAndGoToLocalAreaRoute(pos){

  var query_string = "/local_area/?latitude=" + pos.coords.latitude + "&longitude=" + pos.coords.longitude

  location.replace(query_string);
}
