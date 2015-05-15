// $(".walks.show").ready(function(){
//   html5Geolocation(function (position) {
//     var url = $('#mark-button').attr('data-post-route');
//     displayMap(position);
//     persistGeolocation(position, url);
//     loadGeo(function(data) {
//       map.data.addGeoJson(data);
//       // extendBounds(geojson_data, "Point");
//     });
//   });
// });

// $(".walk-summary").ready(function(){
//   debugger;
//   html5Geolocation(function (position) {
//     var url = $('#square-map').attr('data-post-route');
//     displayMap(position);
//     persistGeolocation(position, url);
//     loadGeo(function(data) {
//       map.data.addGeoJson(data);
//       // extendBounds(geojson_data, "Point");
//     });
//   });
// });

$(document).ready(function(){

  $("#new-walk-button").on('click', newWalk);
  // function(event){
  //   event.preventDefault();
  // });

});

// this is for writing a walk with dogs maybe.

function newWalk(event) {
  event.preventDefault();
  html5Geolocation(function(position, url) {
    var url = $('#new-walk-button').attr('href');
    location.replace(url);


  });

}

function startWalk(event) {
  event.preventDefault();
  console.log('starting walk');
  event.preventDefault();
  var createWalk;

  createWalk = $.ajax({
    url: "/walks",
    type: "post"
  });

  createWalk.done(function(response){
    $("body").html(response);
    // setMapCanvasMobileHeight();
    initializeMap();
  });
}

function markWalk(event){
  var url;

  event.preventDefault();
  url = $(event.target).attr('data-post-route');
  html5Geolocation(function (position) {
    displayMap(position);
    persistGeolocation(position, url);
    loadGeo(function(data) {
      map.data.addGeoJson(data);
      // extendBounds(geojson_data, "Point");
    });
  });
}


// End a Walk
function endWalk(event){
}
