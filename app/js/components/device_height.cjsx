React           = require 'react'
MessageBusMixin = require '../mixins/message_bus'

module.exports = DeviceHeight = React.createClass
  mixins: [ MessageBusMixin ]
  eventDefault: ->
    @publish 'deviceHeight', false

  eventStretch: ->
    @publish 'deviceHeight', true

  render: ->
    <div className="button-toolbar">
      <div className="button-toolbar__title">Device height</div>
      <div className="button-group">
        <button className="button button--medium button--secondary button-group__button" onClick={@eventDefault}>Default</button>
        <button className="button button--medium button--secondary button-group__button" onClick={@eventStretch}>Stretch</button>
      </div>
    </div>
