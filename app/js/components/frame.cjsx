_               = require 'underscore'
React           = require 'react'
Xrespond        = require '../scripts/xrespond'
DeviceStore     = require '../scripts/device_store'
MessageBusMixin = require '../mixins/message_bus'

module.exports = Frame = React.createClass
  mixins: [ MessageBusMixin ]

  getInitialState: ->
    url: Xrespond.local.attr('url')
    key: Date.now()

  onSourceSubmit: (source_value) ->
    @setState
      url: source_value
      key: Date.now()

  componentWillMount: ->
    DeviceStore.registerAndInvoke @_update

  componentDidMount: ->
    @subscribe 'sourceSubmit', @onSourceSubmit

  componentWillUnmount: ->
    DeviceStore.deregister @_update
    @unsubscribe 'sourceSubmit'

  _update: (devices) ->
    that = this
    device = _.filter devices, (d, index) -> index == that.props.id
    @setState device[0] if !_.isEmpty device[0]

  render: ->
    style =
      width: @state.width
      height: @state.height

    <iframe className="screen__viewport" key={@state.key} name={@props.name} src={@state.url} style={style}></iframe>
