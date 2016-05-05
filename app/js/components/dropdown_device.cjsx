React    = require 'react'
Xrespond = require '../scripts/xrespond'

module.exports = DropdownDevice = React.createClass
  handleClick: (e) ->
    @props.handleSubmit Xrespond.device_by_name(@props.name)

  name: ->
    __html: @props.name_marked || @props.name

  render: ->
    subtitle = if @props.subtitle then @props.subtitle else @props.width + ' × ' + @props.height + ' dp'

    <li className="menu-list__item" onClick={@handleClick} onKeyPress={@handleClick} tabIndex="0">
      <div className="menu-list__title" dangerouslySetInnerHTML={@name()}></div>
      <div className="menu-list__description">{subtitle}</div>
    </li>
