Xrespond        = require '../scripts/xrespond'
DeviceStore     = require '../scripts/device_store'
DropdownDevices = require '../components/dropdown_devices'

module.exports = DeviceAdd = React.createClass
  mixins: [ ToggleExpanded ]
  getInitialState: ->
    expanded: false

  handleDropdownSubmit: (attrs) ->
    DeviceStore.create attrs
    @toggleExpanded()

  render: ->

    dropdownDevices = if @state.expanded then <DropdownDevices reset={true} id={@props.id} devices={Xrespond.devices_grouped()} handleSubmit={@handleDropdownSubmit} handleBlur={@toggleExpanded} /> else ''

    <div className="device">
      <div className="device__wrap">
        <div className="tools">
          <div className="tools__group">
            <button className="button button--medium tools__button device__button" onClick={@toggleExpanded}>Add new device</button>
          </div>
        </div>
        {dropdownDevices}
      </div>
    </div>
