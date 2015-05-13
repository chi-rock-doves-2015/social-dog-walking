$(document).ready(function() {
  var $windowWidth = document.documentElement.clientWidth;
  var $windowHeight = document.documentElement.clientHeight;
  var $topBarHeight = $('.top-bar').height();
  var $bodyHeight = $windowHeight - $topBarHeight;

  // $(document).on('load', '#walk-in-progress',(function(){
  // debugger;
  setMapCanvasMobileHeight($bodyHeight, $topBarHeight);

  // }))
});

//for now this is setting map canvas to be square.
//we should  set this to load in a better way than by default on every map.
//but we need it to be square to have room to display buttons during a walk.
//there has been talk of a sticky/fixed footer button bar
//that would be positioned above any map for a full-screen floating buttons effect.
function setMapCanvasMobileHeight(bodyHeight, topBarHeight){
  // debugger;
  setStatsHeight(bodyHeight);
  setButtonsHeight(bodyHeight);
  $('#map-canvas').css({
    "height": bodyHeight * 0.75
  });
}

function setStatsHeight(bodyHeight, topBarHeight){
  $('#stats').css({
    "height": bodyHeight * 0.25//,
    // "position": "fixed",
    // "top": topBarHeight
  });
}


function setButtonsHeight(bodyHeight){
  $('#walk-buttons').css({
    "height" : bodyHeight * 0.15,
    "position": "fixed",
    "bottom": bodyHeight * 0.04,
    ""
  });
}
