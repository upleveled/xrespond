Xrespond = require('./xrespond')

# @TODO: simplify store usage?
module.exports = DeviceStore = BaseStore(Xrespond.local.attr('devices'))
DeviceStore.register Xrespond.local.updateAttr('devices')
DeviceStore.setCreateFunction (new_attrs, internal) ->
  new_resource = _.extend({}, new_attrs)
  newValue = React.addons.update(internal.currentValue, $push: [ new_resource ])
  _.map newValue, Xrespond.resetKeys
  DeviceStore.set newValue

DeviceStore.setUpdateFunction (new_attrs, internal) ->
  r = _.find internal.currentValue, (resource) -> resource.id == new_attrs.id

  if _.isEmpty r
    return DeviceStore.create new_attrs

  index = internal.currentValue.indexOf(r)
  new_resource = _.extend({}, r, new_attrs)
  newValue = React.addons.update(internal.currentValue, $splice: [ [ index, 1, new_resource ] ])
  _.map newValue, Xrespond.resetKeys
  DeviceStore.set newValue

DeviceStore.setRemoveFunction (index, internal) ->
  newValue = React.addons.update(internal.currentValue, $splice: [ [ index, 1 ] ])
  _.map newValue, Xrespond.resetKeys
  DeviceStore.set newValue
