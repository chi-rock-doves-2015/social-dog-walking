var NeighborsView = Backbone.View.extend({
  template: JST["backbone/templates/dashboard_neighbors"],
  noNeighborsTemplate: JST["backbone/templates/no_neighbors"],
  el: "#neighbors",

  initialize: function(){
    this.listenTo(this.collection, 'reset', this.addAll);
  },

  //the if branch doesn't work right now- view only gets rendered once and so we lose our 'neighbors' title among other things.
  render: function() {

      this.$el.html(this.template());

    return this;
  },

  addOne: function(neighbor) {
    var view = new NeighborView({model: neighbor});
    view.render();
    this.$el.append(view.el);

    return this;
  },

  addAll: function() {
    if(this.collection.length === 0){
      this.$el.append(this.noNeighborsTemplate);
    } else {
      this.collection.each(function(neighbor){
        this.addOne(neighbor);
      }, this);
    }
    return this;
  }

});