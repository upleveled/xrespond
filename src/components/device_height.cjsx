module.exports = DeviceHeight = React.createClass
  mixins: [ MessageBusMixin ]
  eventDefault: ->
    @publish 'deviceHeight', false

  eventStretch: ->
    @publish 'deviceHeight', true

  render: ->
    <div className="tools">
      <div className="tools__title">Device height</div>
      <div className="tools__group">
        <button className="button button--medium tools__button" onClick={@eventDefault}>Default</button>
        <button className="button button--medium tools__button" onClick={@eventStretch}>Stretch</button>
      </div>
    </div>
