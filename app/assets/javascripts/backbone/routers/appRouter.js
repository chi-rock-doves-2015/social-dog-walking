var AppRouter = Backbone.Router.extend({
	initialize: function(){
	},

	routes: {
		//currently rails' welcome#index route redirects to /dashboard; this is a url change but doesn't affect bb router functionality
		"backbone": "dashboard",
		//example second route
		"walks/:id": "showWalk"
	},

	dashboard: function(){
		// We may want these vars accessible in global or a MyApp namespace so we can access them later after loading the page?
		var dogsView = new DogsView({collection: new Dogs()});
    var neighborsView = new NeighborsView({collection: new Neighbors()});
		dogsView.render();
  	neighborsView.render();
    
    app.dashboard.fetch({
    	success: function (dashboard, response, options) {
    		console.log(response);
    		dogsView.collection.reset(response.dogs);
    		neighborsView.collection.reset(response.neighbors);
    	}
    });


    // var neighborsView = new NeighborsView({collection: user.neighbors});
    // neighborsView.render();

    // user.neighbors.fetch({
    //   reset: true,
    //   success: function(){
    //     console.log("Found neighbors!");
    //   }
    // });

	},

	showWalk: function(){
		console.log ('check out this walk!');
	}

});

