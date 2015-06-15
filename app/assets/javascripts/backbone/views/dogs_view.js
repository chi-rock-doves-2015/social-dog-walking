var DogsView = Backbone.View.extend({
  template: JST["backbone/templates/dashboard_dogs"],
  noDogsTemplate: JST["backbone/templates/no_dogs"],
  el: "#dogs",

  initialize: function(){
    this.listenTo(this.collection, 'reset', this.addAll);
  },

  render: function() {
    this.$el.html(this.template());

    return this;
  },

  addOne: function(dog) {
    var view = new DogView({model: dog});
    view.render();
    this.$el.append(view.el);

    return this;
  },

  addAll: function() {
    if(this.collection.length === 0){
      this.$el.append(this.noDogsTemplate);
    } else {
      this.collection.each(function(dog){
        this.addOne(dog);
      }, this);
    }
    return this;
  }

});