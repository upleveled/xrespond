require './local'
fuzzy = require '../lib/fuzzy'
Devices = require '../lib/devices'

module.exports = Xrespond =
  local: XrespondLocal()
  devices: -> Devices
  devices_grouped: -> @group_devices_by_type @devices()

  devices_search: (term) ->
    options =
      extract: (d) ->
        _.toArray(_.pick(d, 'name')).join ' '
      pre: '<mark>'
      post: '</mark>'

    results        = fuzzy.filter term, @devices(), options
    sorted_results = _.sortBy results, (o) -> o.index
    matches        = _.map sorted_results, (o) ->
      _.extend {}, o.original, name_marked: o.string

    @group_devices_by_type matches

  device_by_name: (name) ->
    _.find @devices(), (d) ->
      d.name == name

  group_devices_by_type: (devices) ->
    _.groupBy devices, (d) ->
      d.type

  resetKeys: (o, i) ->
    o.id = i
    o
