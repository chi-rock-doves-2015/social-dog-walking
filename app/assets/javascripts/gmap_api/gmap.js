var map;

$(window).load(function() {
  loadScript();
});

function loadScript() {
  var script;

  console.log("map loading ...");

  script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
               '&key=AIzaSyCR_ZOsj0P5_-j5UoT-L50l3ynij4eoY4c' +
               '&libraries=drawing'+
               '&callback=initializeMap';
  document.body.appendChild(script);
}


function initializeMap() {
  var defaultLatLng, mapOptions, featureStyle;

  // defaultLatLng = new google.maps.LatLng(30.055487, 31.279766);

  mapOptions = {
          // zoom: 15,
          // center: defaultLatLng,
          mapTypeId: google.maps.MapTypeId.NORMAL,
          // panControl: false,
  };

  map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);

  if ($("body").hasClass("show")) {
    loadGeo(function(geojson_data) {
      if ($("body").hasClass("users")) {
        map.data.addGeoJson(geojson_data);
        extendBounds(geojson_data, "Polygon");
      }
      else {
        map.data.addGeoJson(geojson_data);
        extendBounds(geojson_data, "Point");
      };
    });
  } else {
    html5Geolocation(displayMap);
  }

  featureStyle = {
    fillColor: "red",
    strokeWeight: 0
  };

  map.data.setStyle(featureStyle);

};

function loadGeo (callback) {
  $.getJSON("/"+$("#map-canvas").attr("data-controller-name")+"/"+$("#map-canvas").attr("data-show-id"), callback)
}

function extendBounds (geojson_data, geotype) {
  var bounds, coordinates;
  bounds = new google.maps.LatLngBounds();

  switch (geotype) {
    case "Polygon":
      coordinates = geojson_data.features[0].geometry.coordinates[0];
      coordinates.forEach( function(coordinate) {
        bounds.extend(new google.maps.LatLng(coordinate[1], coordinate[0]));
        });
      break;
    case "Point":
      markers = geojson_data.features;
      // debugger;
      markers.forEach( function(point) {
        bounds.extend(new google.maps.LatLng(point.geometry.coordinates[1], point.geometry.coordinates[0]));
        });
      break;
  }

  map.fitBounds(bounds);
  map.panToBounds(bounds);
}

function html5Geolocation (successAction, failAction) {
  var errorAction = failAction || onError;
  // function standardAction(position) {
  //   displayMap(position);
  //   successAction(position);
  // }

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(successAction, errorAction);
  } else {
    handleNoGeolocation(false);
  };
}

function displayMap(position) {
  var currentGeolocation;

  map.setZoom(15);

  currentGeolocation = new google.maps.LatLng(position.coords.latitude,
                                              position.coords.longitude);
  map.setCenter(currentGeolocation);
}

function persistGeolocation(position, url) {
  var geolocationData, geolocationAjaxPost;

  geolocationData = {mark: {coords: 'POINT(' + position.coords.latitude + ' ' + position.coords.longitude + ')',

                            accuracy: position.coords.accuracy}
                    };
  geolocationAjaxPost = $.ajax({
                            url: url,
                            type: "post",
                            data: geolocationData,
                          });
  geolocationAjaxPost.done(function(response){
                              $('#stats').html(response)
                          });

}

function onError() {
      handleNoGeolocation(true);
}

function handleNoGeolocation(errorFlag) {
  var content, options, infowindow;

  if (errorFlag) {
    content = 'Error: The Geolocation service failed.';
  } else {
    content = 'Error: Your browser doesn\'t support geolocation.';
  }

  options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };

  infowindow = new google.maps.InfoWindow(options);

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
    var geolocationData = {mark: {coords: 'POINT(' + position.coords.latitude + ' ' + position.coords.longitude + ')', accuracy: position.coords.accuracy}};
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
  })

// MARK BUTTON
  $(".mark").on('click', function(event){
    event.preventDefault();
    navigator.geolocation.getCurrentPosition(onSuccessMark, onError);
  })
});
