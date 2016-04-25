DeviceStore = require '../scripts/device_store'

module.exports = CustomDevice = React.createClass
  getInitialState: ->
      width:  ''
      height: ''

  handleSubmit: (e) ->
    e.preventDefault()
    DeviceStore.update
      name:     'Custom'
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
      <input className="text-input text-input--small custom-screen__text-input" type="number" min="0" placeholder="W" value={@state.width} onChange={@handleChange} name="width" required />
      <div className="custom-screen__divider">×</div>
      <input className="text-input text-input--small custom-screen__text-input" type="number" min="0" placeholder="H" value={@state.height} onChange={@handleChange} name="height" required />
      <button className="button button--small button--submit custom-screen__button" type="submit">Add</button>
    </form>
