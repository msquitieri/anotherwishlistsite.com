App.List = DS.Model.extend({
  title: DS.attr('string'),
  startDate: DS.attr('date'),
  endDate: DS.attr('date'),
  user: DS.belongsTo('user'),
  items: DS.hasMany('item')
});