var NeighborView = Backbone.View.extend({
  template: JST["backbone/templates/neighbor_button"],

  initialize: function() {
  },

  events: {
    "click": "toggleDetails"
  },

  toggleDetails: function(e){
    e.preventDefault();
    this.$el.find(".button").toggleClass("info");
    this.$el.find(".neighbor-details").toggle();
  },

  render: function() {
    this.$el.html(this.template(this.model.attributes));
  }
});