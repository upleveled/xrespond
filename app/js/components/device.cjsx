_               = require 'underscore'
React           = require 'react'
Xrespond        = require '../scripts/xrespond'
DeviceStore     = require '../scripts/device_store'
ToggleExpanded  = require '../mixins/toggle_expanded'
DropdownDevices = require '../components/dropdown_devices'
Frame           = require '../components/frame'

module.exports = Device = React.createClass
  mixins: [ ToggleExpanded ]

  getInitialState: ->
    expanded: false

  componentWillMount: ->
    DeviceStore.registerAndInvoke @_update
    document.addEventListener 'keydown', @handleEscKey, false

  componentWillUnmount: ->
    DeviceStore.deregister @_update
    document.removeEventListener 'keydown', @handleEscKey, false

  _update: (devices) ->
    that = @ # @todo is @still necessary?
    device = _.filter devices, (d, index) -> index == that.props.id
    @setState _.extend({}, device[0], expanded: false)

  handleDropdownSubmit: (attrs) ->
    DeviceStore.update _.extend({}, attrs, id: @props.id)
    @toggleExpanded()

  toggleRotated: ->
    DeviceStore.update
      id: @props.id
      width: @state.height
      height: @state.width

  handleEscKey: (event) ->
    if @state.expanded && event.keyCode == 27 # Escape key
      @setState expanded: false
      @refs.dropdownButton.focus()

  render: ->
    dropdownDevices =
      if (@state.expanded) then <DropdownDevices reset={false} id={@props.id} devices={Xrespond.devices_grouped()} handleSubmit={@handleDropdownSubmit} handleBlur={@toggleExpanded} />
      else ''

    rotate_button = <button className="button button--medium button--square button--secondary button-group__button" onClick={@toggleRotated}>
                      <svg className="icon icon--large">
                        <title>Rotate screen</title>
                        <use xlinkHref="images/icons.svg#icon-rotate-left"/>
                      </svg>
                    </button>

    <article className="device">
      <div className="device__wrap">
        <div className="device-control">
          <div className="button-group">
            <button className="button button--medium button--secondary button-group__button device-control__button" onClick={@toggleExpanded} ref="dropdownButton">
              <div className="button__wrap">
                {@state.name}
                <svg className="icon icon--medium button__icon">
                  <use xlinkHref="images/icons.svg#icon-arrow-drop-down"/>
                </svg>
              </div>
            </button>
            {if @state.rotation then rotate_button else ''}
          </div>
          {dropdownDevices}
        </div>
        <div className="screen-width" style={{minWidth:@state.width+2}}>{@state.width} × {@state.height} dp</div>
        <div className="screen">
          <Frame id={@props.id} name={'XRespond – ' + @state.name} />
        </div>
      </div>
    </article>
