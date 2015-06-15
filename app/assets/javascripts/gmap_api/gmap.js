// var map, infoWindow;

  // infoWindow = new google.maps.InfoWindow({
  //   content: ""
  // });

// $(window).load(function() {
//   loadMapsApiScript();
// });

// function loadMapsApiScript() {
//   var script;

//   console.log("map loading ...");

//   script = document.createElement('script');
//   script.type = 'text/javascript';
//   script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
//                '&key=AIzaSyCR_ZOsj0P5_-j5UoT-L50l3ynij4eoY4c' +
//                '&libraries=drawing'+
//                '&callback=initializeMap';
//   document.body.appendChild(script);
// }


// function initializeMap() {
//   var defaultLatLng, mapOptions, colorValues;

  // defaultLatLng = new google.maps.LatLng(30.055487, 31.279766);

//   mapOptions = {
//     // zoom: 15,
//     // center: defaultLatLng,
//     mapTypeId: google.maps.MapTypeId.NORMAL,
//     disableDefaultUI: true,
//     // panControl: false,
//     styles: [{"featureType":"road","elementType":"labels","stylers":[{"visibility":"on"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#01051d"},{"weight":1}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#01051d"},{"weight":0.8}]},{"featureType":"landscape","stylers":[{"color":"#f5f5f4"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"elementType":"labels","stylers":[{"visibility":"off"}]},{"elementType":"labels.text","stylers":[{"visibility":"on"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#ffffff"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#000000"}]},{"elementType":"labels.icon","stylers":[{"visibility":"on"}]}]
//   };
//
//   map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);
//   if ($("body").hasClass("dashboard")) {
//     if ($("#square-map").attr("data-user-walk-count") === "0") {
//       html5Geolocation(displayMap);
//     } else {
//       loadGeo(function(geojson_data) {
//         map.data.addGeoJson(geojson_data);
//         extendBounds(geojson_data, "Polygon");
//       });
//     }
//   }
//
// if ($("#square-map").hasClass("walk-summary")) {
//   html5Geolocation(function (position) {
//       var url = $('#square-map').attr('data-post-route');
//       displayMap(position);
//
//       loadGeo(function(data) {
//
//         map.data.addGeoJson(data);
//         // extendBounds(geojson_data, "Point");
//       });
//   });
// }
//
//   if ($("body").hasClass("walks")) {
//       html5Geolocation(displayMap);
//   }

  // if ($("body").hasClass("show")) {
  //   if ($("#stats").attr("data-walk-mark-count") === "0") {
  //     html5Geolocation(displayMap);
  //   } else {
  //     loadGeo(function(geojson_data) {
  //       if ($("body").hasClass("users")) {
  //         map.data.addGeoJson(geojson_data);
  //         extendBounds(geojson_data, "Polygon");
  //       }
  //       else {
  //         map.data.addGeoJson(geojson_data);
  //           // map.data.SetStyle(function(feature))
  //         extendBounds(geojson_data, "Point");
  //       }
  //     });
  //   }
  // };

  // map.data.addListener('addfeature', function (event) {
  //   if (event.feature.getProperty('geometry') === "Point") {
  //     map.data.setStyle({
  //       icon: {
  //               path: google.maps.SymbolPath.CIRCLE,
  //               scale: 10,
  //               strokeColor: event.feature.getProperty('strokeColor'),
  //               strokeWeight: 8,
  //               // fillColor: "black"
  //               // scaledSize: new google.maps.Size(32, 32),
  //               // url: "http://vignette2.wikia.nocookie.net/gaia/images/4/41/200px-Green-dot.svg"
  //               // url: event.feature.getProperty('icon')
  //             }
  //     })
  //   } else {
  //
  //     map.data.overrideStyle(event.feature, { zIndex: event.feature.getProperty('zIndex'),
  //                                             fillColor: event.feature.getProperty('fillColor'),
  //                                             strokeColor: event.feature.getProperty('strokeColor'),
  //                                             strokeWeight: event.feature.getProperty('strokeWeight'),
  //                                             fillOpacity: event.feature.getProperty('fillOpacity')
  //                                             // icon:
  //                                           });
  //     }
  // });

  // $("#load-territory-geo-layer").click(function() {
  //   map.data.forEach(function(feature) {
  //     map.data.remove(feature);
  //   });

  //   if ($("#square-map").attr("data-user-walk-count") === "0") {
  //     html5Geolocation(displayMap);
  //   } else {
  //     loadGeo(function(geojson_data) {

  //       map.data.addGeoJson(geojson_data);
  //       extendBounds(geojson_data, "Polygon");
  //     });
  //   }
  // })

  // $("#load-neighborhood-geo-layer").click(function() {
  //   loadTerritoriesGeoLayer(function(geojson_data) {
      // map.data.forEach(function(feature) {
      //   map.data.remove(feature);
      // });
  //     map.data.addGeoJson(geojson_data);
  //     extendBounds(geojson_data, "Polygon");
  //   });
  // })

//   $("#load-local-area-geo-layer").click(function() {
// //CLEAR MAP FEATURES
//     loadLocalAreaGeoLayer(function(geojson_data) {
//       map.data.forEach(function(feature) {
//         map.data.remove(feature);
//       });
//       map.data.addGeoJson(geojson_data);
//       extendBounds(geojson_data, "Polygon");
//     });
//   })
//
// }

// function setColorStyle (feature) {
//
//   return {
//     fillColor: feature.getProperty('color'),
//     strokeWeight: 0
//   };
// }

// function loadGeo (callback) {
//   if ($("#map-canvas").attr("data-controller-name") === "users") {
//   $.getJSON("/"+$("#map-canvas").attr("data-controller-name")+"/"+$("#map-canvas").attr("data-user-id"), callback);
//   } else if ($("#square-map").hasClass("walk-summary")) {
//     $.getJSON("/"+$("#map-canvas").attr("data-controller-name")+"/"+$("#square-map").attr("data-walk-id"), callback);
//   } else {
//   $.getJSON("/"+$("#map-canvas").attr("data-controller-name")+"/"+$("#map-canvas").attr("data-walk-id"), callback);
//   }
// }
//
// function loadTerritoriesGeoLayer (callback) {
//   $.getJSON("/users/territory", callback);
// }
//
// function loadLocalAreaGeoLayer (callback) {
//   html5Geolocation(postToServer);
// }

// function postToServer(position) {
//   $.post("/local_areas", returnGeolocationCoordinates(position), function(geojson_data, textStatus) {

//     map.data.forEach(function(feature) {
//       map.data.remove(feature);
//     });

//     map.data.addGeoJson(geojson_data);
//     extendBounds(geojson_data, "Polygon");
//   });
// }

// function extendBounds (geojson_data, geotype) {
//   var bounds, coordinates;
//   bounds = new google.maps.LatLngBounds();
//
//   switch (geotype) {
//     case "Polygon":
//       coordinates = geojson_data.features[0].geometry.coordinates[0];
//       coordinates.forEach( function(coordinate) {
//         bounds.extend(new google.maps.LatLng(coordinate[1], coordinate[0]));
//         });
//       break;
//     case "Point":
//       markers = geojson_data.features;
//       markers.forEach( function(point) {
//         bounds.extend(new google.maps.LatLng(point.geometry.coordinates[1], point.geometry.coordinates[0]));
//         });
//       break;
//   }
//
//   map.fitBounds(bounds);
//   map.panToBounds(bounds);
// }

// function html5Geolocation (successAction, failAction) {
//   var errorAction = failAction || onError;
//   // function standardAction(position) {
//   //   displayMap(position);
//   //   successAction(position);
//   // }
//
//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(successAction, errorAction);
//   } else {
//     handleNoGeolocation(false);
//   };
// }
//
// function returnGeolocationCoordinates(position) {
//
//   coordinates = {
//     latitude: position.coords.latitude,
//     longitude: position.coords.longitude
//   }
//
//   return coordinates
// }
//
// function displayMap(position) {
//   var currentGeolocation;
//
//   map.setZoom(15);
//   currentGeolocation = new google.maps.LatLng(position.coords.latitude,
//                                               position.coords.longitude);
//   map.setCenter(currentGeolocation);
// }

// function persistGeolocation(position, url) {
//   var geolocationData, geolocationAjaxPost;

//   geolocationData = {mark: {coords: 'POINT(' + position.coords.latitude + ' ' + position.coords.longitude + ')',

//                             accuracy: position.coords.accuracy}
//                     };

//   geolocationAjaxPost = $.ajax({
//                             url: url,
//                             type: "post",
//                             data: geolocationData,
//                           });

//   geolocationAjaxPost.done(function(response){
//                               $('#stats').html(response)
//                           });

// }

// function onError() {
//       handleNoGeolocation(true);
// }
//
// function handleNoGeolocation(errorFlag) {
//   var content, options, infowindow;
//
//   if (errorFlag) {
//     content = 'Error: The Geolocation service failed.';
//   } else {
//     content = 'Error: Your browser doesn\'t support geolocation.';
//   }
//
//   options = {
//     map: map,
//     position: new google.maps.LatLng(60, 105),
//     content: content
//   };
//
//   infowindow = new google.maps.InfoWindow(options);
//
//   map.setCenter(options.position);
// }

//////////////////////////////////////////////////////////////////////////////////////////////////


// $(document).ready(function(){
//
//   function onSuccessMark(position){
//     displayMap(position);
//     ajaxMarkGeolocation(position);
//   }
//   // AJAXIFYING BUTTONS
//   // added for create walk button
//     function ajaxInitialGeolocationData(position){
//       var geolocationData = {mark: {coords: 'POINT(' + position.coords.latitude + ' ' + position.coords.longitude + ')', accuracy: position.coords.accuracy}};
//       // first we need to get the walk id that was just created so that we can send the next ajax request to the server
//       var geolocationPost = $.ajax({
//                                 url: '/walks',
//                                 type: 'post',
//                                 data: geolocationData
//       })
//
//       geolocationPost.done(function(response){
//         console.log(response);
//         $('#status').children().remove();
//         $('#status').append(response);
//       })
//     }
//


  // BUTTON : RECENT WALKS
  // $("#recent-walks-btn").on('click', function(event){
  //   event.preventDefault();
  //   map.data.loadGeoJson("/walks/1");
  // })

  // MARK BUTTON
//   $(".mark").on('click', function(event){
//     event.preventDefault();
//     navigator.geolocation.getCurrentPosition(onSuccessMark, onError);
// //   })
// });
