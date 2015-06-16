var Dashboard = Backbone.Model.extend({
  url: "/dashboard",


  initialize: function(){
    //not necessary?
    this.dogs = new Dogs();
    this.neighbors = new Neighbors();
  },

  parse: function(response){

  }

});