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

  dropdown: ->
    <DropdownDevices
      reset        = {true}
      key          = {@props.id}
      id           = {@props.id}
      devices      = {Xrespond.devices_grouped()}
      handleSubmit = {@handleDropdownSubmit}
      handleBlur   = {@toggleExpanded}
    />

  render: ->
    <div className="device">
      <div className="device__wrap">
        <div className="tools">
          <div className="tools__group">
            <button className="button button--medium tools__button device__button" onClick={@toggleExpanded}>Add new device</button>
          </div>
        </div>
        {if @state.expanded then @dropdown() else ''}
      </div>
    </div>
