XrespondDefaults = {
  devices: function() {
    var deviceNames = [
      'Apple iPhone 6 Plus',
      'Google Nexus 7',
      'Apple iPad Air',
      'Microsoft Surface Pro'
    ]
    return defaultDevices = _.map(deviceNames, function(name, i){
      var d = _.find(Devices, function(d) { return d.name == name })
      return _.extend(d, {id: i})
    })
  },
  url: ''
}
