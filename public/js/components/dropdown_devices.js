
var XrespondDropdownDevices = React.createClass({
  getInitialState: function() {
    return {
      devices: this.props.devices,
      search: '',
      localClick: false
    }
  },
  search: function(value) {
    var devices = Xrespond.devices_search(value)
    this.setState({ search: value, devices: devices })
  },
  handleInputChange: function(e) {
    this.search(e.target.value)
  },
  handleClear: function() {
    this.setState({localClick: true})
    this.search('')
  },
  render: function() {
    var that = this;
    var sections = _.map(this.state.devices, function(list, label){
      var devices = list.map(function(o, j){
        return <XrespondDropdownDevice key={o.name} name={o.name} width={o.width} height={o.height} handleSubmit={that.props.handleSubmit} />
      })

      return (
        <div className="menu__section" key={label}>
          <div className="menu__title">{label}</div>
          <div className="menu-list">
            {devices}
          </div>
        </div>
      )
    })
    var empty = <div className="menu__section"><XrespondDropdownDevice title="No such device..." subtitle="Show all devices" handleClick={this.handleClear} /></div>
    return (
      <div className="dropdown dropdown--device">
        <div className="search">
          <div className="search__title">Search for device</div>
          <input className="text-input text-input--small search__text-input" placeholder="Type, name, screen size" value={this.state.search} onChange={this.handleInputChange} ref="deviceInput" />
        </div>

        <div className="menu">
          {_.isEmpty(this.state.devices) ? empty : sections}
        </div>

        <XrespondCustomDevice id={this.props.id} />
        <XrespondDropdownToolbar reset={this.props.reset} id={this.props.id} />
      </div>
    )
  },
  componentDidMount: function() {
    document.addEventListener("click", this.documentClickHandler)
    this.refs.deviceInput.focus()
  },
  componentWillUnmount: function() {
    document.removeEventListener("click", this.documentClickHandler)
  },
  localClick: function() {
    // Offer a bailout for global click handling when we need to handle a
    // local click on an element that is destroyed before the global event is fired.
    // I.e, the 'No such device...' click, which should reset devices
    // without hiding the whole dropdown.
    if (this.state.localClick == true) {
      this.setState({localClick: false})
      return true
    } else {
      return false
    }
  },
  documentClickHandler: function(evt) {
    if (this.localClick()) { return }

    // https://github.com/facebook/react/issues/579
    var localNode = ReactDOM.findDOMNode(this)

    var source = evt.target
    var found = false
    // if source=local then this event came from "somewhere" inside and should be ignored.
    while(source.parentNode) {
      found = (source === localNode)
      if(found) return
      source = source.parentNode
    }

    // not found: genuine outside event. Handle it.
    this.props.handleBlur()
  }
})

var XrespondDropdownDevice = React.createClass({
  handleClick: function(e) {
    this.props.handleSubmit(_.clone(this.props))
  },
  render: function() {
    var subtitle = this.props.subtitle ? this.props.subtitle : this.props.width + " × " + this.props.height + " dp"
    return (
      <div className="menu-list__item" tabindex="0" onKeyPress={this.handleClick} onClick={this.handleClick}>
        <div className="menu-list__title">{this.props.name}</div>
        <div className="menu-list__description">{subtitle}</div>
      </div>
    )
  }
})
