
var XrespondCustomDevice = React.createClass({
  getInitialState: function() {
    return { width: '', height: '' }
  },
  handleSubmit: function(e) {
    e.preventDefault()
    DeviceStore.update({
      name:  'Custom',
      id:     this.props.id,
      width:  parseInt(this.state.width),
      height: parseInt(this.state.height),
      rotation: true
    })
  },
  handleChange: function(e) {
    var newstate = {}
    newstate[e.target.name] = e.target.value
    this.setState(newstate);
  },
  render: function() {
    return (
      <form className="custom-screen" onSubmit={this.handleSubmit}>
        <div className="custom-screen__title">Custom screen size</div>
        <input className="text-input text-input--small custom-screen__text-input" type="number" min="0" placeholder="W" value={this.state.width} onChange={this.handleChange} name="width" required />
        <div className="custom-screen__divider">×</div>
        <input className="text-input text-input--small custom-screen__text-input" type="number" min="0" placeholder="H" value={this.state.height} onChange={this.handleChange} name="height" required />
        <button className="button button--small button--submit custom-screen__button" type="submit">Add</button>
      </form>
    )
  }
})
