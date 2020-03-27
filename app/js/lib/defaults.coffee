_ = require('underscore')

module.exports = XrespondDefaults =
  devices: ->
    deviceNames = [
      'Apple iPhone 5'
      'Google Nexus 7'
      'Apple iPad Air'
      'Apple iPad Pro 12.9"'
      'Apple MacBook Air 11.6"'
    ]
    defaultDevices = _.map(deviceNames, (name, i) ->
      d = _.find(Devices, (d) ->
        d.name == name
      )
      _.extend {}, d, id: i
    )
  url: ''
