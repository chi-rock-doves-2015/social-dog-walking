
//instantiate router immediately
var appRouter = new AppRouter();
var myApp = {
	dashboard: new Dashboard(),

  pollPosition: function(){
    console.log('Begin polling position...')
    if (Modernizr.geolocation) {
      this.watchID = navigator.geolocation.watchPosition(this.storePosition, this.positionError, {enableHighAccuracy: true});
    } else {
      alert("You must enable location tracking to take a walk!")
    }
  },

  stopPollingPosition: function(){
    console.log('Stop polling position.');
    navigator.geolocation.clearWatch(myApp.watchID);
  },

  storePosition: function(position){
    console.log('polled!')
    myApp.currentCoords = position.coords;
    map.setCenter({lat: position.coords.latitude, lng: position.coords.longitude});
  },

  positionError: function(error){
    console.log(error.message);
  },

  loadMapsApiScript: function() {
    var script;

    console.log("BB map loading ...");

    script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
                 '&key=AIzaSyCR_ZOsj0P5_-j5UoT-L50l3ynij4eoY4c' +
                 '&libraries=drawing'+
                 '&callback=myApp.initialize';
    document.body.appendChild(script);
  },

  //initialize entire app once google maps api has loaded
  initialize: function(){
    console.log("Initializing App");
    this.mapOptions = {
      zoom: 15,
      //******************************************
      center: new google.maps.LatLng(41.88983, -87.63747),
      //******************************************
      mapTypeId: google.maps.MapTypeId.NORMAL,
      // disableDefaultUI: true,
      // panControl: false,
      styles:[{"featureType":"road","elementType":"labels","stylers":[{"visibility":"on"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#01051d"},{"weight":1}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#01051d"},{"weight":0.8}]},{"featureType":"landscape","stylers":[{"color":"#f5f5f4"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"elementType":"labels","stylers":[{"visibility":"off"}]},{"elementType":"labels.text","stylers":[{"visibility":"on"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#ffffff"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#000000"}]},{"elementType":"labels.icon","stylers":[{"visibility":"on"}]}]
    };
    Backbone.history.start();
  }
};

$(window).load(function() {
  myApp.loadMapsApiScript();
});





// Load Google Maps API
