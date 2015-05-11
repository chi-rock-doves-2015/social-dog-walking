//using this to initialize map when starting a walk
function initializeMap(){
  if (navigator.geolocation) {
   navigator.geolocation.getCurrentPosition(makeMap, console.log("failed to get position"))
  } else {
    // Browser doesn't support Geolocation
    console.log("position not supported");
  };
}


// just generally makes an all-purpose map from a position.
function makeMap(position){
  var lat = position.coords.latitude;
  var lon = position.coords.longitude;
  var acc = position.coords.accuracy;
  var center = new google.maps.LatLng(lat, lon)
  var mapOptions = {
          zoom: 15,
          center: center,
          mapTypeId: google.maps.MapTypeId.NORMAL,
          panControl: false,
          // scaleControl: false,
          // streetViewControl: true,
          // overviewMapControl: true
        };
        // initializing map
        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
}
