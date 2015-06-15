var Mark = Backbone.Model.extend({
  defaults:{

  },

  longitude: function () {
  	return this.coords.x
  },
  
  latitude: function () {
  	return this.coords.y
  },
});