App.SessionNewController = Ember.ObjectController.extend({
  actions: {
    createSession: function() {
      this.get('model').save().then(function(data) {
        console.log('data returned from session: ');
        console.log(data);
      });
    },

    destroySession: function() {
      $.ajax({
        url: '/api/v1/sessions/1',
        method: 'delete'
      });
    }
  }
});