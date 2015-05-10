$(document).ready(function() {
  setMapCanvasMobileHeight();
});

function setMapCanvasMobileHeight(){
  var $width = document.documentElement.clientWidth;
  var $height = document.documentElement.clientHeight;
  console.log($width);
  $('#map-canvas').css("height", ($height * 0.75));
};
