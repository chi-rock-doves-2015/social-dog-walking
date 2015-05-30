var DogView = Backbone.View.extend({
  template: JST["backbone/templates/dog_button"],
  detailTemplate: JST["backbone/templates/dog_details"],

  initialize: function() {
    console.log("Creating dog view");
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