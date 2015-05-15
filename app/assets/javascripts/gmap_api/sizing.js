$(document).ready(function() {
  var $windowWidth = document.documentElement.clientWidth;
  var $windowHeight = document.documentElement.clientHeight;
  var $topBarHeight = $('.top-bar').height();
  var $bodyHeight = $windowHeight - $topBarHeight;

if ($('#walk-in-progress-map').length) {
  mapCanvasWalkInProgress($bodyHeight, $topBarHeight);
}else if ($('#square-map').length ){
  mapCanvasSquareView($windowWidth, $topBarHeight);
}

});




/////////////////////////

function mapCanvasWalkInProgress(bodyHeight, topBarHeight){
  // debugger;
  console.log('setting walk in progress layout');
  setStatsHeight(bodyHeight);
  setButtonsHeight(bodyHeight);
  $('#map-canvas').css({
    "height": bodyHeight * 0.82
  });
}

function setStatsHeight(bodyHeight, topBarHeight){
  $('#stats').css({
    "height": bodyHeight * 0.18
  });
}


function setButtonsHeight(bodyHeight){
  $('#walk-buttons').css({
    "height" : bodyHeight * 0.15,
    "position": "fixed",
    "bottom": bodyHeight * 0.04
  });
}
////////////////////////

function mapCanvasSquareView(width, topBarHeight){
  console.log('setting square map layout');
  // var $width = document.documentElement.clientWidth;
  // var $height = document.documentElement.clientHeight;
  // console.log($width);
  $('#map-canvas').css({
    "height": width,
    "position": "fixed",
    "top": "topBarHeight"
  });
}
