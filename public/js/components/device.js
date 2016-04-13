
var XrespondDevice = React.createClass({
  mixins: [ToggleExpanded],

  getInitialState: function() {
    return { expanded: false }
  },
  componentWillMount: function() {
    DeviceStore.registerAndInvoke(this._update)
  },
  componentWillUnmount: function() {
    DeviceStore.deregister(this._update)
    document.removeEventListener("click", this.documentClickHandler)
  },
  _update: function(devices) {
    var that = this
    device = _.filter(devices, function(d, index){ return index == that.props.id })
    this.setState(_.extend(device[0], {expanded: false}))
  },
  handleDropdownSubmit: function(attrs) {
    DeviceStore.update(_.extend(attrs, {id: this.props.id}))
    this.toggleExpanded()
  },
  svg: function() { return {__html: '<svg class="icon button__icon"><title>Rotate screen</title><use xlink:href="#icon-rotate-screen"></svg>'} },
  render: function() {

    dropdownDevices = (this.state.expanded)
      ? <XrespondDropdownDevices reset={false} id={this.props.id} devices={Xrespond.devices_grouped()} handleSubmit={this.handleDropdownSubmit} handleBlur={this.toggleExpanded} />
      : ''

    device_title = this.state.name + ' ― ' + this.state.width + ' × ' + this.state.height + ' dp'

    return (
      <div className='device'>
        <div className="device__wrap">
          <div className="tools">
            <div className="tools__group">
              <button className="button button--medium tools__button device__button" onClick={this.toggleExpanded}>
                {device_title}
              </button>
              <button className="button button--medium button--square tools__button" dangerouslySetInnerHTML={this.svg()}></button>
            </div>
          </div>

          {dropdownDevices}

          <div className="screen">
            <XrespondFrame name={device_title} id={this.props.id} />
          </div>
        </div>
      </div>
    )
  }
})
