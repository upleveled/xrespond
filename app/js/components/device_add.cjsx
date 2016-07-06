React           = require 'react'
Xrespond        = require '../scripts/xrespond'
DeviceStore     = require '../scripts/device_store'
ToggleExpanded  = require '../mixins/toggle_expanded'
DropdownDevices = require '../components/dropdown_devices'

module.exports = DeviceAdd = React.createClass
  mixins: [ ToggleExpanded ]

  componentWillMount: ->
    document.addEventListener 'keydown', @handleEscKey, false

  componentWillUnmount: ->
    document.removeEventListener 'keydown', @handleEscKey, false

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

  handleEscKey: (event) ->
    if @state.expanded && event.keyCode == 27 # Escape key
      @setState expanded: false
      @refs.dropdownButton.focus()

  render: ->
    <article className="device">
      <div className="device__wrap">
        <div className="device-control">
          <div className="button-group">
            <button className="button button--medium button--secondary button-group__button device-control__button" onClick={@toggleExpanded} ref="dropdownButton">
              <div className="button__wrap">
                Add new device
                <svg className="icon icon--medium button__icon">
                  <use xlinkHref="#icon-dropdown"></use>
                </svg>
              </div>
            </button>
          </div>
          {if @state.expanded then @dropdown() else ''}
        </div>
      </div>
    </article>
