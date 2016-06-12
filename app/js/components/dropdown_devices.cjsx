_               = require 'underscore'
React           = require 'react'
ReactDOM        = require 'react-dom'
Xrespond        = require '../scripts/xrespond'
DropdownDevice  = require '../components/dropdown_device'
CustomDevice    = require '../components/custom_device'
DropdownToolbar = require '../components/dropdown_toolbar'

module.exports = DropdownDevices = React.createClass
  getInitialState: ->
    devices: @props.devices
    search: ''
    localClick: false

  search: (value) ->
    devices = Xrespond.devices_search(value)
    @setState
      search: value
      devices: devices

  handleInputChange: (e) ->
    @search e.target.value

  handleClear: ->
    @setState localClick: true
    @search ''

  render: ->
    that = this
    sections = _.map(@state.devices, (list, label) ->
      devices = list.map((o, j) ->
        <DropdownDevice key={o.name} name={o.name} name_marked={o.name_marked} width={o.width} height={o.height} handleSubmit={that.props.handleSubmit} />
      )
      <li className="menu__section" key={label}>
        <div className="menu__title">{label}</div>
        <ol className="menu-list">
          {devices}
        </ol>
      </li>
    )
    empty = <li className="menu__section">
              <ol className="menu-list">
                <DropdownDevice name="No device found" subtitle="Show all devices" handleSubmit={@handleClear} />
              </ol>
            </li>

    <div className="dropdown device-control__dropdown">
      <div className="device-search">
        <div className="device-search__title">Search for device</div>
        <input autoFocus className="text-input text-input--small device-search__text-input" onChange={@handleInputChange} placeholder="Enter device name" value={@state.search} />
      </div>
      <ol className="menu">
        {if _.isEmpty(@state.devices) then empty else sections}
      </ol>
      <CustomDevice id={@props.id} />
      <DropdownToolbar reset={@props.reset} id={@props.id} />
    </div>

  componentDidMount: ->
    document.addEventListener 'click', @documentClickHandler

  componentWillUnmount: ->
    document.removeEventListener 'click', @documentClickHandler

  localClick: ->
    # Offer a bailout for global click handling when we need to handle a
    # local click on an element that is destroyed before the global event is fired.
    # I.e, the 'No such device...' click, which should reset devices
    # without hiding the whole dropdown.
    if @state.localClick == true
      @setState localClick: false
      true
    else
      false

  documentClickHandler: (evt) ->
    return if @localClick()

    # https://github.com/facebook/react/issues/579
    localNode = ReactDOM.findDOMNode(@)
    source = evt.target
    found = false
    # if source=local then @event came from "somewhere" inside and should be ignored.
    while source.parentNode
      found = (source == localNode)
      return if found
      source = source.parentNode

    # not found: genuine outside event. Handle it.
    @props.handleBlur()
