React           = require 'react'
base64          = require 'base64-js'

ClickSource     = require '../lib/click_source'
ToggleExpanded  = require '../mixins/toggle_expanded'
MessageBusMixin = require '../mixins/message_bus'

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

  getInitialState: ->
    url: @generateUrl()
    expanded: false

  _update: ->
    @setState url: @generateUrl()

  generateUrl: ->
    # @TODO Generic way to access the backend?
    sharedata = btoa(window.localStorage.xrespond)
    window.location.host + '/?share=' + sharedata

  handleBlur: ->
    @setState expanded: false
    @refs.dropdownButton.focus()

  handleEscKey: (event) ->
    if @state.expanded && event.keyCode == 27 # Escape key
      @handleBlur()

  documentClickHandler: (evt) ->
    if ClickSource.isGlobal(evt, @) then @handleBlur()

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
      <button className="button button--medium button--secondary" onClick={@toggleExpanded} ref="dropdownButton">Share</button>
      {box}
    </div>
