$(document).ready(function(){
  console.log('new-walk');
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
    var url = $(event.target).attr('data-post-route');
    displayMap(position);
    persistGeolocation(position, url);
    loadGeo(function(data) {
      map.data.addGeoJson(data);
    });
  });
}


// End a Walk
function endWalk(event){
}
