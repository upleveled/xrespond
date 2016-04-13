
var XrespondFrame = React.createClass({
  mixins: [MessageBusMixin],
  getInitialState: function() {
    return {
      url: Xrespond.local.attr('url'),
      key: Date.now()
    }
  },
  onSourceSubmit: function(source_value) {
    this.setState({
      url: source_value,
      key: Date.now()}
    )
  },
  componentWillMount: function() {
    DeviceStore.registerAndInvoke(this._update)
  },
  componentDidMount: function() {
    this.subscribe('sourceSubmit', this.onSourceSubmit)
  },
  componentWillUnmount: function() {
    DeviceStore.deregister(this._update)
    this.unsubscribe('sourceSubmit')
  },
  _update: function(devices) {
    var that = this
    device = _.filter(devices, function(d, index){ return index == that.props.id })
    this.setState(device[0])
  },
  render: function() {
    var style = {width: this.state.width, height: this.state.height}
    return (
      <iframe name={this.props.name} key={this.state.key} className="screen__viewport" src={this.state.url} style={style}></iframe>
    )
  }
})
