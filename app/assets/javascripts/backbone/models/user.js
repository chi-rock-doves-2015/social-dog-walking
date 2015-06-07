var User = Backbone.Model.extend({
  defaults: {

  },

  //this is an experiment in generating a users dogs... work in progress

  initialize: function(){
    this.dogs = new Dogs();
    // we actually don't need this nested route any more because dogs#index is fetching current_user's dogs
    this.dogs.url = 'users/' + this.id + '/dogs';
    this.neighbors = new Neighbors();
    this.neighbors.url = 'users/' + this.id + '/neighbors';
  }

  //or just pass the param?
  // dogs = new Dogs({user_id: this.id})
});