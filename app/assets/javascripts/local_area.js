$("#pumpkin").ready(function(){
  html5Geolocation (sendLocationToServer);
});

function sendLocationToServer(pos){
  $.ajax({
    url: '/local_area',
    method: "GET",
    data: {latitude: pos.coords.latitude, longitude: pos.coords.longitude},
    dataType: "html"
  });
}
