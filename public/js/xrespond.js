
var Xrespond = {
  local: XrespondLocal(),
  devices: function() {
    return Devices
  },
  devices_grouped: function() {
    return this.group_devices_by_type(this.devices())
  },
  devices_search: function(term) {
    var options = {
      extract: function(d) {
        return _.toArray(_.pick(d, 'type', 'name', 'width', 'height')).join(' ')
      }
    }
    var results = fuzzy.filter(term, this.devices(), options)
    var matches = _.pluck(results, 'original')

    return this.group_devices_by_type(matches)
  },
  group_devices_by_type: function(devices) {
    return _.groupBy(devices, function(d) { return d.type })
  },
  resetKeys: function(o, i) {
    o.id = i
    return o
  }
}

MessageBus.subscribe(Xrespond.local, 'sourceSubmit',  Xrespond.local.updateAttr('url'))
MessageBus.subscribe(Xrespond.local, 'deviceHeight', Xrespond.local.updateAttr('stretch'))

// @TODO: simplify store usage
DeviceStore = BaseStore(Xrespond.local.attr('devices'))
DeviceStore.register(Xrespond.local.updateAttr('devices'))

DeviceStore.setCreateFunction(function(new_resource, internal) {
  var newValue = React.addons.update(internal.currentValue, { $push: [new_resource] })
  _.map(newValue, Xrespond.resetKeys)
  DeviceStore.set(newValue)
})

DeviceStore.setUpdateFunction(function(new_attrs, internal){
  var r = _.find(internal.currentValue, function(resource) {
    return resource.id == new_attrs.id
  })
  var index = internal.currentValue.indexOf(r)

  var new_resource = _.extend({}, r, new_attrs)
  var newValue = React.addons.update(internal.currentValue, { $splice: [[index, 1, new_resource]] })
  _.map(newValue, Xrespond.resetKeys)
  DeviceStore.set(newValue)
})

DeviceStore.setRemoveFunction(function(index, internal){
  var newValue = React.addons.update(internal.currentValue, { $splice: [[index, 1]] })
  _.map(newValue, Xrespond.resetKeys)
  DeviceStore.set(newValue)
})

var mount = function(component, id) {
  ReactDOM.render(component, document.getElementById(id))
}

mount(<XrespondDevices />,      'main')
mount(<XrespondSource />,       'source')
mount(<XrespondDeviceHeight />, 'device-height')
