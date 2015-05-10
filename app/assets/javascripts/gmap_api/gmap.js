$(window).load(function() {
  loadScript();
});

// google.maps.event.addDomListener(window, "resize", function() {
//  var center = map.getCenter();
//  google.maps.event.trigger(map, "resize");
//  map.setCenter(center);
// });

var map;

function initialize() {

  var defaultLatLng = new google.maps.LatLng(30.055487, 31.279766)

  var mapOptions = {
          zoom: 15,
          center: defaultLatLng,
          mapTypeId: google.maps.MapTypeId.NORMAL,
          panControl: true,
          // scaleControl: false,
          // streetViewControl: true,
          // overviewMapControl: true
        };
        // initializing map
        map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);

  if (navigator.geolocation) {
   navigator.geolocation.getCurrentPosition(onSuccess, onError)
   } else {
    // Browser doesn't support Geolocation
  handleNoGeolocation(false);
  };

  map.data.loadGeoJson("/walks/1");

};


// RECENT WALKS



function onSuccess(position) {
  displayMap(position);
  console.log(position.coords);
  // ajaxGeolocation(position);
}

function displayMap(position) {
      var pos = new google.maps.LatLng(position.coords.latitude,
                                        position.coords.longitude);

      var infowindow = new google.maps.InfoWindow({
        map: map,
        position: pos,
        content: "Wherever you go, there you are."
      });

      map.setCenter(pos);
}
function ajaxGeolocation(position) {
  var geolocationData, serializedData;
  geolocationData = {mark: {latitude: position.coords.latitude, longitude: position.coords.longitude, accuracy: position.coords.accuracy}};
  // serializedData = geolocationData;
  var geolocationPost = $.ajax({
                            url: "/walks/1/marks",
                            type: "post",
                            data: geolocationData,

                          });
  geolocationPost.done(function(response){
    $('body').css('background', 'red');
  });

}

function onError() {
      handleNoGeolocation(true);
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
//////////////////////////////////////////////////////////////////////////////////////////////////
$(document).ready(function(){


function onSuccessMark(position){
  displayMap(position);
  ajaxMarkGeolocation(position);
}
// AJAXIFYING BUTTONS
// added for create walk button
  function ajaxInitialGeolocationData(position){
    var geolocationData = {mark: {latitude: position.coords.latitude, longitude: position.coords.longitude, accuracy: position.coords.accuracy}};
    // first we need to get the walk id that was just created so that we can send the next ajax request to the server
    var geolocationPost = $.ajax({
                              url: '/walks',
                              type: 'post',
                              data: geolocationData
    })

    geolocationPost.done(function(response){
      console.log(response);
      $('#status').children().remove();
      $('#status').append(response);
    })
  }



// BUTTON : RECENT WALKS
  $("#recent-walks-btn").on('click', function(event){
    event.preventDefault();
    map.data.loadGeoJson("/walks/1");
    debugger;
  })

// MARK BUTTON
  $(".mark").on('click', function(event){
    event.preventDefault();
    navigator.geolocation.getCurrentPosition(onSuccessMark, onError);
  })
});

