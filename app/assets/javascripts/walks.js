function startWalk() {
  var createWalk;

  createWalk = $.ajax({
    url: "/walks",
    type: "post"
  })

  createWalk.done(function(response){
    $("body").html(response);
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
  });

  loadGeo(function(data) {
    map.data.addGeoJson(data)
  });

}

// function postMark(position, url){
//   // debugger;
//   // var url = $('#mark-button').attr('href')
//   var geolocationData = {mark: {latitude: position.coords.latitude, longitude: position.coords.longitude, accuracy: position.coords.accuracy}};
//   var createRequest = $.ajax({
//     url: url,
//     type: 'post',
//     data: geolocationData
//   })
//   createRequest.done(function(response){
//     $('#stats').html(response)
//   })
// }

// End a Walk
function endWalk(event){
}
