App.SessionNewRoute = Ember.Route.extend({
  model: function() {
    return this.store.createRecord('session');
  }
});