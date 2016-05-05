React       = require 'react'
DeviceStore = require '../scripts/device_store'

module.exports = CustomDevice = React.createClass
  getInitialState: ->
      width:  ''
      height: ''

  handleSubmit: (e) ->
    e.preventDefault()
    DeviceStore.update
      name:     'Custom device'
      id:       @props.id
      width:    parseInt(@state.width)
      height:   parseInt(@state.height)
      rotation: true

  handleChange: (e) ->
    newstate = {}
    newstate[e.target.name] = e.target.value
    @setState newstate

  render: ->
    <form className="custom-screen" onSubmit={@handleSubmit}>
      <div className="custom-screen__title">Custom screen size</div>
      <input className="text-input text-input--small custom-screen__text-input" min="0" name="width" onChange={@handleChange} placeholder="w" required type="number" value={@state.width} />
      <div className="custom-screen__sign">×</div>
      <input className="text-input text-input--small custom-screen__text-input" min="0" name="height" onChange={@handleChange} placeholder="h" required type="number" value={@state.height} />
      <button className="button button--small button--primary custom-screen__button">Add</button>
    </form>
