React           = require 'react'
Device          = require './device'
DeviceAdd       = require './device_add'
Xrespond        = require '../scripts/xrespond'
DeviceStore     = require '../scripts/device_store'
MessageBusMixin = require '../mixins/message_bus'

module.exports = XrespondDevices = React.createClass
  mixins: [ MessageBusMixin ]

  getInitialState: ->
    stretchsize: Xrespond.local.attr('stretch')

  componentWillMount: ->
    DeviceStore.registerAndInvoke @_update

  componentDidMount: ->
    @subscribe 'deviceHeight', @_onDeviceControl

  componentWillUnmount: ->
    DeviceStore.deregister @_update
    @unsubscribe 'deviceHeight'

  _onDeviceControl: (control_value) ->
    @setState stretchsize: control_value

  _update: (devices) ->
    @setState collection: devices

  render: ->
    devices = @state.collection.map (p) -> <Device key={p.id} id={p.id} />
    add_device = <DeviceAdd key={@state.collection.length} id={@state.collection.length} />
    device_class = if @state.stretchsize then ' main__wrap--stretch' else ''

    <div className={'main__wrap' + device_class}>{devices}{add_device}</div>
