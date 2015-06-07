var DogView = Backbone.View.extend({
  template: JST["backbone/templates/dog_button"],

  initialize: function() {
  },

  events: {
    "click": "toggleDetails"
  },

  toggleDetails: function(e){
    e.preventDefault();
    this.$el.find(".button").toggleClass("info");
    this.$el.find(".dog-details").toggle();
  },

  render: function() {
    this.$el.html(this.template(this.model.attributes));
  }
});