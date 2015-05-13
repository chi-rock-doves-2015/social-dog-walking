$(document).ready(function() {
  var $windowWidth = document.documentElement.clientWidth;
  var $windowHeight = document.documentElement.clientHeight;
  var $topBarHeight = $('.top-bar').height();
  var $bodyHeight = $windowHeight - $topBarHeight;
  setMapCanvasMobileHeight();
});

//for now this is setting map canvas to be square.
//we should  set this to load in a better way than by default on every map.
//but we need it to be square to have room to display buttons during a walk.
//there has been talk of a sticky/fixed footer button bar
//that would be positioned above any map for a full-screen floating buttons effect.
function setMapCanvasMobileHeight(){
  console.log('poot');
  debugger;
  console.log($bodyHeight);
  setStatsHeight();
  setButtonsHeight();
  $('#map-canvas').css("height", $bodyHeight * 0.45);
}

function setStatsHeight(){
  console.log('staffs');
  $('#stats').css("height", $bodyHeight * 0.3);
}


function setButtonsHeight(){
  console.log("bootoons");
  $('#walk-buttons').css({
    "height" : $bodyHeight * 0.15,
    "position": "fixed",
    "bottom": 0
  });
}
