Xrespond        = require '../scripts/xrespond'
DeviceStore     = require '../scripts/device_store'
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

  svg: ->
    __html: '<svg class="icon button__icon"><title>Rotate screen</title><use xlink:href="#icon-rotate-left"></svg>'

  toggleRotated: ->
    DeviceStore.update
      id: @props.id
      width: @state.height
      height: @state.width

  handleEscKey: (event) ->
    if event.keyCode == 27
      @setState expanded: false

  render: ->
    dropdownDevices =
      if (@state.expanded) then <DropdownDevices reset={false} id={@props.id} devices={Xrespond.devices_grouped()} handleSubmit={@handleDropdownSubmit} handleBlur={@toggleExpanded} />
      else ''

    device_title = "#{@state.name} ― #{@state.width} × #{@state.height} dp"
    rotate_button = <button className="button button--medium button--square tools__button" dangerouslySetInnerHTML={@svg()} onClick={@toggleRotated}></button>

    <div className="device">
      <div className="device__wrap">
        <div className="tools">
          <div className="tools__group">
            <button className="button button--medium tools__button device__button" onClick={@toggleExpanded}>{device_title}</button>
            {@state.rotation ? rotate_button : ''}
          </div>
        </div>
        {dropdownDevices}
        <div className="screen">
          <Frame id={@props.id} name={@state.name} />
        </div>
      </div>
    </div>
