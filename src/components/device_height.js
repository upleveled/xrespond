
var XrespondDeviceHeight = React.createClass({
  mixins: [MessageBusMixin],
  eventDefault: function() {
    this.publish('deviceHeight', false)
  },
  eventStretch: function() {
    this.publish('deviceHeight', true)
  },
  render: function() {
    return (
      <div className="tools">
        <div className="tools__title">Device height</div>
        <div className="tools__group">
          <button className="button button--medium tools__button" onClick={this.eventDefault}>Default</button>
          <button className="button button--medium tools__button" onClick={this.eventStretch}>Stretch</button>
        </div>
      </div>
    )
  }
})
