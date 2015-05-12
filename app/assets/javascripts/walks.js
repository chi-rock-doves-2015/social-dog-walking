function startWalk() {
  var createWalk;

  createWalk = $.ajax({
    url: "/walks",
    type: "post"
  })

  createWalk.done(function(response){
    $("body").html(response);
    $("#start-walk-btn").hide();
    setMapCanvasMobileHeight();
    initializeMap();
  })
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
      map.data.addGeoJson(data)
    });
  });
}


// End a Walk
function endWalk(event){
}
