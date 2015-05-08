$(window).load(function() {
  loadScript();
});

var map;

function initialize() {

  var mapOptions = {
          center: new google.maps.LatLng(30.055487, 31.279766),
          zoom: 30,
          mapTypeId: google.maps.MapTypeId.NORMAL,
          panControl: true,
          scaleControl: false,
          streetViewControl: true,
          overviewMapControl: true
        };
        // initializing map
        map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);

  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = new google.maps.LatLng(position.coords.latitude,
                                        position.coords.longitude);

      var infowindow = new google.maps.InfoWindow({
        map: map,
        position: pos,
        content: 'Josh is here eating his lunch.'
      });

      map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
  handleNoGeolocation(false);
  }

   // geocoding
      // var geocoding  = new google.maps.Geocoder();
      // $("#submit_button_geocoding").click(function(){
      //   codeAddress(geocoding);
      // });
      // $("#submit_button_reverse").click(function(){
      //   codeLatLng(geocoding);
      // });

}

function loadScript() {
	console.log("map loading ...");
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
    // API KEY
    '&key=AIzaSyCR_ZOsj0P5_-j5UoT-L50l3ynij4eoY4c' +
    '&libraries=drawing'+
    '&callback=initialize';
  document.body.appendChild(script);
}

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = 'Error: The Geolocation service failed.';
  } else {
    var content = 'Error: Your browser doesn\'t support geolocation.';
  }

  var options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };

  var infowindow = new google.maps.InfoWindow(options);
  map.setCenter(options.position);
}

