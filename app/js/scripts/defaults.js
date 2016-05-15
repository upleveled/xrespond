_ = require('underscore')

module.exports = XrespondDefaults = {
  devices: function() {
    var deviceNames = [
      'Apple iPhone 5',
      'Google Nexus 7',
      'Apple iPad Air',
      'Apple iPad Pro 12.9\"',
      'Apple MacBook Air 11.6\"'
    ]
    return defaultDevices = _.map(deviceNames, function(name, i){
      var d = _.find(Devices, function(d) { return d.name == name })
      return _.extend({}, d, {id: i})
    })
  },
  url: ''
}
