var Dashboard = Backbone.Model.extend({
  url: "/dashboard",

  initialize: function(){
    this.set('dogs', new Dogs());
    this.set ('neighbors', new Neighbors());
  },
});