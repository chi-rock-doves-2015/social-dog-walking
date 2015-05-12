$(document).ready(function() {
  setMapCanvasMobileHeight();
});

//for now this is setting map canvas to be square.
//we should  set this to load in a better way than by default on every map.
//but we need it to be square to have room to display buttons during a walk.
//there has been talk of a sticky/fixed footer button bar
//that would be positioned above any map for a full-screen floating buttons effect.
function setMapCanvasMobileHeight(){
  var $width = document.documentElement.clientWidth;
  var $height = document.documentElement.clientHeight;
  // console.log($width);
  $('#map-canvas').css("height", ($width));
};
