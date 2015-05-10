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
