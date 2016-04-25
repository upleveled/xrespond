Xrespond = require '../scripts/xrespond'

module.exports = DropdownDevice = React.createClass
  handleClick: (e) ->
    @props.handleSubmit Xrespond.device_by_name(@props.name)

  render: ->
    subtitle = if @props.subtitle then @props.subtitle else @props.width + ' × ' + @props.height + ' dp'

    <div className="menu-list__item" tabindex="0" onKeyPress={@handleClick} onClick={@handleClick}>
      <div className="menu-list__title">{@props.name}</div>
      <div className="menu-list__description">{subtitle}</div>
    </div>
