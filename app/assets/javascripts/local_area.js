$("#pumpkin").ready(function(){
  html5Geolocation (sendLocationToServer);
});

function sendLocationToServer(pos){
  $.ajax({
    url: '/local_area',
    method: "GET",
    data: {current_position: pos},
    dataType: "html"
  });
}
