
var XrespondDropdownToolbar = React.createClass({
  handleRemove: function() {
    if (this.props.reset) {
      DeviceStore.set(XrespondDefaults.devices())
    } else {
      DeviceStore.remove(this.props.id)
    }
  },
  render: function() {
    var remove_text = this.props.reset ? 'Reset devices' : 'Remove device'
    return (
      <div className="device-control">
        <button className="button button--small button--remove" onClick={this.handleRemove}>{remove_text}</button>
      </div>
    )
  }
})
