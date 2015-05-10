function startWalk() {
  console.log("Starting walk!")
  var createWalk = $.ajax({
    url: "/walks",
    type: "post",
  })

  createWalk.done(function(response){
    debugger;
    $("#the-yield").html(response);
    setMapCanvasMobileHeight();
    initializeMap();
  })
}
