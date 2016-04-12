
var XrespondDeviceControl = React.createClass({
  mixins: [MessageBusMixin],
  eventDefault: function() {
    this.publish('deviceControl', false)
  },
  eventStretch: function() {
    this.publish('deviceControl', true)
  },
  render: function() {
    return (
      <div className="device-control">
        <div className="device-control__title">Device height</div>
        <button className="button device-control__button" onClick={this.eventDefault}>Default</button>
        <button className="button device-control__button" onClick={this.eventStretch}>Stretch</button>
      </div>
    )
  }
})
