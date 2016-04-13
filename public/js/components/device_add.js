
var XrespondDeviceAdd = React.createClass({
  mixins: [ToggleExpanded],

  getInitialState: function() {
    return {
      expanded: false
    }
  },
  handleDropdownSubmit: function(attrs) {
    DeviceStore.create(attrs)
    this.toggleExpanded()
  },
  render: function() {

    dropdownDevices = (this.state.expanded)
      ? <XrespondDropdownDevices reset={true} id={this.props.id} devices={Xrespond.devices_grouped()} handleSubmit={this.handleDropdownSubmit} handleBlur={this.toggleExpanded} />
      : ''

    return (
      <div className="device__wrap">
        <div className="tools">
          <div className="tools__group">
            <button className="button button--medium tools__button device__button" onClick={this.toggleExpanded}>
              Add new device
            </button>
          </div>
        </div>

        {dropdownDevices}
      </div>
    )
  }
})
