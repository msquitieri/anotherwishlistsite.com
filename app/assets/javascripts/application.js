// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require ./anotherwishlistsite_com

// for more details see: http://emberjs.com/guides/application/
App = Ember.Application.create({
  rootElement: '#ember-app',

  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  LOG_VIEW_LOOKUPS: true
});

Ember.Application.initializer({
  name: 'setApiKey',
  initialize: function (container, application) {
    Ember.$.ajaxSetup({
      beforeSend:function(xhr, settings){
        xhr.setRequestHeader('X-api-key', '1234');
      }
    });
  }
});

Ember.Application.initializer({
  name: "setCurrentUser",
  after: 'ember-data',

  initialize: function (container, application) {
    application.deferReadiness();

    $.ajax({
      url: '/api/v1/sessions/current',
    }).then(function (data) {
      if (data.user) {
        var store = container.lookup('store:main');
        var user = store.find('user', data.user.id);
        container.register('user:current', user, {singleton: true, instantiate: false})
        // controller = container.lookup('controller:currentUser').set('content', user);
        application.inject('controller', 'currentUser', 'user:current');
        application.advanceReadiness();
      } else {
        application.advanceReadiness();
      }
    });
  }
})

//= require_tree .
