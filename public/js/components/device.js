
var XrespondDevice = React.createClass({
  mixins: [ToggleExpanded],

  getInitialState: function() {
    return { expanded: false }
  },
  componentWillMount: function() {
    DeviceStore.registerAndInvoke(this._update)
    document.addEventListener("keydown", this.handleEscKey, false)
  },
  componentWillUnmount: function() {
    DeviceStore.deregister(this._update)
    document.removeEventListener("keydown", this.handleEscKey, false)
  },
  _update: function(devices) {
    var that = this
    device = _.filter(devices, function(d, index){ return index == that.props.id })
    this.setState(_.extend({}, device[0], {expanded: false}))
  },
  handleDropdownSubmit: function(attrs) {
    DeviceStore.update(_.extend({}, attrs, {id: this.props.id}))
    this.toggleExpanded()
  },
  svg: function() { return {__html: '<svg class="icon button__icon"><title>Rotate screen</title><use xlink:href="#icon-rotate-screen"></svg>'} },
  toggleRotated: function() {
    DeviceStore.update({id: this.props.id, width: this.state.height, height: this.state.width})
  },
  handleEscKey: function(event) {
    if (event.keyCode == 27) {
      this.setState({expanded: false})
    }
  },
  render: function() {

    dropdownDevices = (this.state.expanded)
      ? <XrespondDropdownDevices reset={false} id={this.props.id} devices={Xrespond.devices_grouped()} handleSubmit={this.handleDropdownSubmit} handleBlur={this.toggleExpanded} />
      : ''

    device_title = this.state.name + ' ― ' + this.state.width + ' × ' + this.state.height + ' dp'
    rotate_button = <button className="button button--medium button--square tools__button" dangerouslySetInnerHTML={this.svg()} onClick={this.toggleRotated}></button>

    return (
      <div className="device">
        <div className="device__wrap">
          <div className="tools">
            <div className="tools__group">
              <button className="button button--medium tools__button device__button" onClick={this.toggleExpanded}>{device_title}</button>
              {this.state.rotation ? rotate_button : ''}
            </div>
          </div>
          {dropdownDevices}
          <div className="screen">
            <XrespondFrame id={this.props.id} name={this.state.name} />
          </div>
        </div>
      </div>
    )
  }
})
