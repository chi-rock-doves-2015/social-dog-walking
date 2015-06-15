// defining inherited views in line bc load order is messing causing LiveWalkView to be undefined when inheriting from map view

var MapView, LiveWalkView;

MapView = Backbone.View.extend({

	template: JST['backbone/templates/map'],
	el: "#map",
	model: Map,
  colors: ["#FFFF00", "#9900FF", "#CC6600", "#009933", "#FF00FF", "#669999", "#CC3300", "#FF33CC", "#00CC99", "#333399", "#660066", "#993333", "#996633", "#333300", "#33CCFF"],

	initialize: function(){
    this.mapBounds = new google.maps.LatLngBounds();
	},

	render: function(){
		this.$el.html(this.template());
		this.mapCanvasSquare();
		map = new google.maps.Map(document.getElementById("map-canvas"), myApp.mapOptions);
		map.setCenter(this.model.get('centroid'))
    this.addMapListeners(map);
	},

  // !!! Need to refine this or write new setstyle functions
  addMapListeners: function(map){
    map.data.addListener('addfeature', function (event) {
      if (event.feature.getProperty('geometry') === "Point") {
        map.data.setStyle({
          icon: {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 10,
          strokeColor: event.feature.getProperty('strokeColor'),
          strokeWeight: 4,
          // fillColor: "black"
          // scaledSize: new google.maps.Size(32, 32),
          // url: "http://vignette2.wikia.nocookie.net/gaia/images/4/41/200px-Green-dot.svg"
          // url: event.feature.getProperty('icon')
                }
        })
      } else {
        // Polygon walk
        map.data.overrideStyle(event.feature, { 
          zIndex: event.feature.getProperty('zIndex'),
          fillColor: event.feature.getProperty('fillColor'),
          strokeColor: event.feature.getProperty('strokeColor'),
          strokeWeight: event.feature.getProperty('strokeWeight'),
          fillOpacity: event.feature.getProperty('fillOpacity')
          // icon:
        });
        }
    });
  },

	// options: {walksCollection || walk, geotype, color/style properties}
  renderGeoJson: function(options){
    var geotype = options.geotype,
    		color = options.color,
        zIndex = options.zIndex,
        strokeWeight = options.strokeWeight,
    		geoJson, collection, walk;

    // Route to geoJson constructor depending on type of data received
    if (collection = options.walksCollection) {
    	geoJson = this.buildCollectionGeoJson(collection, geotype, color, zIndex, strokeWeight);
    }

    if (geoJson) {
      map.data.addGeoJson(geoJson);
      this.extendBounds(geoJson, geotype);
      //  set style ???
    }
  },

	extendBounds: function (geoJson, geotype) {
  	var coordinates, bounds = this.mapBounds;

  	switch (geotype) {

      case "Polygon":
        geoJson.features.forEach(function(feature) {
          coordinates = feature.geometry.coordinates[0];
          coordinates.forEach( function(coordinate) {
            bounds.extend(new google.maps.LatLng(coordinate[1], coordinate[0]));
            });
        });
        break;

      case "Point":
        markers = geoJson.features;
        markers.forEach( function(point) {
          bounds.extend(new google.maps.LatLng(point.geometry.coordinates[1], point.geometry.coordinates[0]));
          });
      break;
    }

    map.fitBounds(bounds);
    map.panToBounds(bounds);

  },

	buildCollectionGeoJson: function(walksCollection, geotype, color, zIndex, strokeWeight){
		var that = this;
    var featureCollection = {
      type: "FeatureCollection",
      features: []
    };
    console.log(walksCollection);
    walksCollection.forEach(function(walk){
    	var walkFeatureGeoJson;
    	if (walkFeatureGeoJson = that.buildWalkGeoJson(walk, geotype, color, zIndex, strokeWeight)){
    		console.log(walkFeatureGeoJson);
    		featureCollection.features.push(walkFeatureGeoJson);
    	};
	  });

	    // console.log(featureCollection);
    if (featureCollection.features[0]) {
    	console.log(featureCollection);
      return featureCollection;
    } else {
      return false;
    }
	},

	buildWalkGeoJson: function(walk, geotype, color, zIndex, strokeWeight){
		//only include walks with at least three marks
		if (walk.length > 2){
			var walkFeature = {
				type: "Feature",
				geometry: {
					type: geotype,
					coordinates: [walk]
				},
        properties: {
          geometry: geotype,
          zIndex: zIndex,
          fillColor: color,
          strokeColor: color,
          strokeWeight: strokeWeight,
          fillOpacity: 0.5
        }
			};
			//close loop if geometry is polygon
			if (geotype == 'Polygon'){
				walkFeature.geometry.coordinates[0].push(walkFeature.geometry.coordinates[0][0]);
			}

      return walkFeature;
		} else {
			return false;
		}
	},

	mapCanvasSquare: function() {
		console.log('setting square map layout');
		var $width = document.documentElement.clientWidth;
		var $height = $('.top-bar').height();
		$('#map-canvas').css({
		"height": $width,
		// "position": "fixed",
		// "top": $height,
		"background-color": "grey"
		});
	},

  clearMap: function(){
    map.data.forEach(function(feature) {
      map.data.remove(feature);
    });
  },
});

LiveWalkView = MapView.extend({
  template: JST['backbone/templates/live_walk'],

  model: Walk,

  el: "#backbone-container",

  render: function(){
    this.$el.html(this.template());
    this.mapCanvasSquare();
    map = new google.maps.Map(document.getElementById("map-canvas"), myApp.mapOptions);
    //poll and recenter map at optimal interval
    myApp.pollPosition();
    this.addMapListeners(map);
    map.setZoom(18);
    map.data.setStyle({
      geotype: "LineString",
      strokeWeight: 2,
      strokeColor: 'black',
      strokeOpacity: 0.5
    });
  },

  initialize: function(){
    this.mapBounds = new google.maps.LatLngBounds();

    this.listenTo($('#map-canvas'), 'click', function(){console.log('click')});
  },
  // after successful post mark, pull current data.toJson and render as a collection with one color, post new mark as a new current position/latest mark color

  markWalk: function(event){
    var url;

    console.log("mark walk **************");
    url = $(event.target).attr('data-post-route');
    this.persistGeolocation(url);
    // loadGeo(function(data) {
    //   map.data.addGeoJson(data);
    // });
  },

  persistGeolocation: function(url) {
    var that = this,
        geolocationData, 
        geolocationAjaxPost, 
        coords = [myApp.currentCoords.latitude, myApp.currentCoords.longitude];

    geolocationData = {mark: {coords: 'POINT(' + myApp.currentCoords.latitude + ' ' + myApp.currentCoords.longitude + ')',
                              accuracy: myApp.currentCoords.accuracy}
                      };

    geolocationAjaxPost = $.ajax({
                              url: url,
                              type: "post",
                              data: geolocationData,
                            });

    geolocationAjaxPost.done(function(response){
      // !!! not very backbone...
      $('#stats').html(response);

      console.log(this);
      that.renderGeoJson({
        coords: coords,
      });
      
    });
  },

  renderGeoJson: function(options){
    // How to build feature collection 
    var geotype = options.geotype,
        color = options.color,
        zIndex = options.zIndex,
        strokeWeight = options.strokeWeight,
        geoJson, collection, walk;
    console.log('rendering...');
  }
});
  // addPointToMap: function(coords){
  //   this.renderGeoJson({

  //   })
  // }

  // mapView.renderGeoJson({
  //           walksCollection: neighbor,
  //           geoType: "Polygon",
  //           color: color,
  //           strokeWeight: 0,
  //           zIndex: (500 - index)
  //         });

  // renderGeoJson: function(options){
  //   var geotype = options.geotype || "Polygon",
  //       color = options.color,
  //       zIndex = options.zIndex,
  //       strokeWeight = options.strokeWeight,
  //       geoJson, collection, walk;

  //   // Route to geoJson constructor depending on type of data received
  //   if (collection = options.walksCollection) {
  //     geoJson = this.buildCollectionGeoJson(collection, geotype, color, zIndex, strokeWeight);
  //   }

  //   if (geoJson) {
  //     map.data.addGeoJson(geoJson);
  //     this.extendBounds(geoJson, geotype);
  //     //  set style
  //   }
  // },


