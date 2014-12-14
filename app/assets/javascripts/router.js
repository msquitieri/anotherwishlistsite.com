// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.resource('lists', { path: '/lists/:id' });

  this.resource('session', function() {
    this.route('new');
  });

});
