React            = require 'react'
DeviceStore      = require '../scripts/device_store'
XrespondDefaults = require '../lib/defaults'

module.exports = DropdownToolbar = React.createClass
  handleRemove: ->
    if @props.reset
      DeviceStore.set XrespondDefaults.devices()
    else
      DeviceStore.remove @props.id

  render: ->
    remove_text = if @props.reset then 'Reset devices' else 'Remove device'

    <div className="remove-device">
      <button className="button button--small button--danger remove-device__button" onClick={@handleRemove}>{remove_text}</button>
    </div>
