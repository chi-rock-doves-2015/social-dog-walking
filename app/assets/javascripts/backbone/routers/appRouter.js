var AppRouter = Backbone.Router.extend({
	initialize: function(){
	},

	routes: {
		//currently rails' welcome#index route redirects to /dashboard; this is a url change but doesn't affect bb router functionality
		"backbone": "dashboard",
    "live-walk": 'liveWalk',
		//example second route
		"walks/:id": "showWalk"
	},

	dashboard: function(){
    myApp.stopPollingPosition();
		// We may want these vars accessible in global or a MyApp namespace so we can access them later after loading the page? eg mapView below
		var dogsView = new DogsView({collection: new Dogs()});
    var neighborsView = new NeighborsView({collection: new Neighbors()});
    var mapView = myApp.mapView = new MapView({model: new Map()});


    myApp.dashboard.fetch({
    	success: function (dashboard, response, options) {
        dogsView.render();
        neighborsView.render();
        dogsView.collection.reset(response.dogs);
        neighborsView.collection.reset(response.neighbors);

        // Parse dashboard walks into currentUser and neighbor walks, centroid into LatLng
        mapView.model.set({
          walks: {
            currentUser: response.walks,
            neighbors: response.neighbors.map(function(neighbor){
              return neighbor["walks"]
            })
          },
          centroid: response.centroid

        });
        mapView.render();

        // Load Current User's Walk Collection
        // renderGeoJson  options: {walksCollection || walk || marksCollection || mark, geotype, color/style properties}

        mapView.renderGeoJson({
          walksCollection: mapView.model.get('walks').currentUser,
          geotype: "Polygon",
          color: "#ff292c",
          zIndex: 9999,
          strokeWeight: 4
        });

        // Iterate over neighbors and load each of their walk collections
        mapView.model.get('walks').neighbors.forEach(function(neighbor, index){
          var color = mapView.colors[index]
          mapView.renderGeoJson({
            walksCollection: neighbor,
            geotype: "Polygon",
            color: color,
            strokeWeight: 0,
            zIndex: (500 - index)
          });
        });

      }
    });
  // $(document).foundation();
  // $(document).foundation('dropdown', 'reflow');
  },

  liveWalk: function(){
    var liveWalkView = myApp.liveWalkView = new LiveWalkView({model: new Walk()});
    liveWalkView.render();
  },

	showWalk: function(){
    //we may not need this view.
		console.log ('check out this walk!');
	}

});

