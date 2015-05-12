
// function onError() {
//    handleNoGeolocation(true);
// }

// function html5Geolocation (successAction, failAction) {
//   var errorAction = failAction || onError;
//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(successAction, failAction);
//   } else {
//     handleNoGeolocation(false);
//   };
// }

// function html5Geolocation (successAction, failAction) {
//   var errorAction = failAction || onError;

//   function standardAction(position) {
//     displayMap(position);
//     successAction(position);
//   }

//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(standardAction, errorAction);
//   } else {
//     handleNoGeolocation(false);
//   };
// }




// function markWalk(event){
//   var url;
//   event.preventDefault();


//   html5Geolocation(function (position) {
//     var url = $(event.target).attr('data-post-route');
//     displayMap(position);
//     PersistGeolocation(position, url);
//   });



//   loadGeo(function(data) {
//     map.data.addGeoJson(data)
//   });

// }

// function onSuccess(position) {

// }

// navigator.geolocation.getCurrentPosition(onSuccess);
