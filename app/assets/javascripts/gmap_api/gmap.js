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

  if (navigator.geolocation) {
   navigator.geolocation.getCurrentPosition(onSuccess, onError)
   } else {
    // Browser doesn't support Geolocation
  handleNoGeolocation(false);
  }
};

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
        content: 'Josh is typing on this computer.'
      });

      map.setCenter(pos);
}
function ajaxGeolocation(position) {
  var geolocationData, serializedData;
  geolocationData = {mark: {latitude: position.coords.latitude, longitude: position.coords.longitude, accuracy: position.coords.accuracy}};
  serializedData = geolocationData;
  var geolocationPost = $.ajax({
                            url: '/walks/1/marks',
                            type: 'post',
                            data: serializedData,

                          });
  geolocationPost.done(function(response){
    $('body').css('background', 'red');
    console.log(response['response']);
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




$(document).ready(function(){

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
// added for create walk button
function onSuccessBeginWalk(position){
  displayMap(position);
  ajaxInitialGeolocationData(position); 
}
//
//

// AJAXIFYING BUTTONS

// START WALK BUTTON


  $('.button_to').on('click', function(event){
    event.preventDefault();
    navigator.geolocation.getCurrentPosition(onSuccessBeginWalk, onError);
    // console.log(geolocationData);
    // createWalk = $.ajax({
    //   url: '/walks',
    //   type: 'post',
      
    // })

    // // // need to get location... this could end up in a lot of repetative code that needs to be refactored

    // createWalk.done(function(response){
    //   $('#status').children().remove();
    //   $('#status').append(response);
    // })
  })
});

