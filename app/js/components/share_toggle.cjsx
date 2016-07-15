React           = require 'react'
base64          = require 'base64-js'

ToggleExpanded  = require '../mixins/toggle_expanded'
MessageBusMixin = require '../mixins/message_bus'

module.exports = ShareToggle = React.createClass
  mixins: [ ToggleExpanded, MessageBusMixin ]

  componentDidMount: ->
    @subscribe 'settingsSave', @_update

  componentWillUnmount: ->
    @unsubscribe 'settingsSave'

  getInitialState: ->
    url: @_generateUrl()
    expanded: false

  _update: ->
    @setState url: @_generateUrl()

  _generateUrl: ->
    # @TODO Generic way to access the backend?
    sharedata = btoa(window.localStorage.xrespond)
    window.location.host + '/?share=' + sharedata

  urlBox: ->
    <div className="dropdown share-toggle__dropdown">
      <div className="share">
        <div className="share__title">Copy the following link to share this view with anyone</div>
        <input type='text' className="text-input text-input--small share__text-input" value={@state.url} readOnly />
      </div>
    </div>

  render: ->
    box = if @state.expanded then @urlBox() else ''

    <div className="share-toggle__wrap">
      <button className="button button--medium button--secondary" onClick={@toggleExpanded}>Share</button>
      {box}
    </div>
