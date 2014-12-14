App.User = DS.Model.extend({
  email: DS.attr('string'),
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  lists: DS.hasMany('list')
});