function startWalk() {
  console.log("Starting walk!")
  var startWalk = $.ajax({
    url: "/walks",
    type: "post",
  })

  startWalk.done(function(response){
    debugger;
    $("#the-yield").html(response)
  })
}
