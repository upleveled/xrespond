React           = require 'react'
base64          = require 'base64-js'

ClickSource     = require '../lib/click_source'
ToggleExpanded  = require '../mixins/toggle_expanded'
MessageBusMixin = require '../mixins/message_bus'
XrespondLocal   = require '../scripts/local'

module.exports = ShareToggle = React.createClass
  mixins: [ ToggleExpanded, MessageBusMixin ]

  componentDidMount: ->
    @subscribe 'settingsSave', @_update

  componentWillMount: ->
    document.addEventListener 'keydown', @handleEscKey, false
    document.addEventListener 'click', @documentClickHandler

  componentWillUnmount: ->
    @unsubscribe 'settingsSave'
    document.removeEventListener 'keydown', @handleEscKey, false
    document.removeEventListener 'click', @documentClickHandler

  componentDidUpdate: ->
    if @state.expanded
      @refs.input.setSelectionRange(0,100000)

  getInitialState: ->
    url: @generateUrl()
    expanded: false

  _update: ->
    @setState url: @generateUrl()

  generateUrl: ->
    sharedata = btoa(JSON.stringify(XrespondLocal.load()))
    window.location.host + '/?share=' + sharedata

  handleBlur: ->
    if @state.expanded
      @setState expanded: false

  handleEscKey: (event) ->
    if @state.expanded && event.keyCode == 27 # Escape key
      @handleBlur()
      @refs.dropdownButton.focus()

  documentClickHandler: (evt) ->
    if ClickSource.isGlobal(evt, @) then @handleBlur()

  urlBox: ->
    <div className="dropdown share-toggle__dropdown">
      <div className="share">
        <div className="share__title">Copy the following link to share this view with anyone</div>
        <input type='text' className="text-input text-input--small share__text-input" value={@state.url} readOnly ref="input" autoFocus />
      </div>
    </div>

  render: ->
    box = if @state.expanded then @urlBox() else ''

    <div className="share-toggle__wrap">
      <button className="button button--medium button--secondary" onClick={@toggleExpanded} ref="dropdownButton">Share</button>
      {box}
    </div>
