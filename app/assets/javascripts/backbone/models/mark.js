var Mark = Backbone.Model.extend({
  defaults:{

  },

  longitude: function () {
  	return this.coords.y
  },
  
  latitude: function () {
  	return this.coords.x
  },
});