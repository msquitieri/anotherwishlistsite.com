App.Item = DS.Model.extend({
  title: DS.attr('string'),
  price: DS.attr('string'),
  notes: DS.attr('string'),
  image: DS.attr('string'),
  link: DS.attr('string'),
  quantity: DS.attr('number'),
  priority: DS.attr('number'),
  reserved: DS.attr('boolean'),
  list: DS.belongsTo('list')
});