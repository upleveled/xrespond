MessageBus = require '../lib/message_bus'

module.exports = MessageBusMixin =
  publish: MessageBus.publish.bind(global.Registry)
  subscribe: (channel, callback) ->
    MessageBus.subscribe this, channel, callback
    return
  unsubscribe: (channel) ->
    MessageBus.unsubscribe this, channel
    return
  componentWillUnmount: ->
    Object.keys(@[SUBSCRIPTIONS]).forEach @unsubscribe
    return
