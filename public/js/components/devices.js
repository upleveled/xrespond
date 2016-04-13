
var XrespondDevices = React.createClass({
  mixins: [MessageBusMixin],

  getInitialState: function() {
    return { stretchsize: Xrespond.local.attr('stretch') }
  },
  componentWillMount: function() {
    DeviceStore.registerAndInvoke(this._update)
  },
  componentDidMount: function() {
    this.subscribe('deviceControl', this._onDeviceControl)
  },
  componentWillUnmount: function() {
    DeviceStore.deregister(this._update)
    this.unsubscribe('deviceControl')
  },
  _onDeviceControl: function(control_value) {
    this.setState({stretchsize: control_value})
  },
  _update: function(devices) {
    this.setState({ collection: devices })
  },
  render: function() {
    var devices = this.state.collection.map(function(p){
      return(<XrespondDevice key={p.id} id={p.id} />)
    })

    var add_device = <XrespondDeviceAdd id={-1} />
    var device_class = this.state.stretchsize ? ' main__wrap--stretch' : ''

    return (<div className={'main__wrap' + device_class}>{devices}{add_device}</div>)
  }
})
