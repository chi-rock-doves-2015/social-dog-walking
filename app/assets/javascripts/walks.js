/// Walking Functions ///

// Create a Walk
function startWalk() {
  console.log("Starting walk!")
  var createWalk = $.ajax({
    url: "/walks",
    type: "post",
  })

  createWalk.done(function(response){
    $("#the-yield").html(response);
    setMapCanvasMobileHeight();
    initializeMap();
  })
}


// End a Walk
function endWalk(event){
  event.preventDefault();
  debugger;
}



// Mark a position

function markWalk(event){
  event.preventDefault();
  var url = $(event.target).attr('href');
  // debugger;
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position){
      postMark(position, url);
      makeMap(position);
    }, onError);
  } else{
    console.log("position not supported :/");
  }
}

//// wrote this when i was being redirected to index. i don't know why
// function markWalk(event){
//   event.preventDefault();

//   var url = $(event.target).attr('href'); //why isn't this scoping into postMark????? :/
//   if (navigator.geolocation) {
//     debugger;
//     navigator.geolocation.getCurrentPosition(postMark, onError);
//   } else {
//     console.log("position not supported :/");
//   }
// }

function postMark(position, url){
  // debugger;
  // var url = $('#mark-button').attr('href')
  var geolocationData = {mark: {latitude: position.coords.latitude, longitude: position.coords.longitude, accuracy: position.coords.accuracy}};
  var createRequest = $.ajax({
    url: url,
    type: 'post',
    data: geolocationData
  })
  createRequest.done(function(response){
    $('#stats').html(response)
  })
}


