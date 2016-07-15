# Based off https://github.com/tungd/react-catalyst

Registry = global.Registry = {}
module.exports = MessageBus =
  registry: {}
  publish: (channel, data) ->
    if Registry[channel]
      Registry[channel].forEach (subscriber) =>
        subscriber['__subscriptions'][channel].call subscriber, data
        return
    return
  subscribe: (component, channel, callback) ->
    # TODO: guard from multiple subscribe
    if !Registry[channel]
      Registry[channel] = []
    Registry[channel].push component
    if !component['__subscriptions']
      component['__subscriptions'] = {}
    component['__subscriptions'][channel] = callback
    return
  unsubscribe: (component, channel) ->
    if Registry[channel]
      nth = Registry[channel].indexOf(component)
      if nth > -1
        Registry[channel].splice nth, 1
      delete component['__subscriptions'][channel]
    return
