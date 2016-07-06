module.exports = BaseStore = (initialValue) ->
  registry = []

  @get = ->
    internal.currentValue

  @set = (newValue) ->
    internal.currentValue = newValue
    internal.emit internal.currentValue, internal.keys(newValue)

  @register = (fn) ->
    if typeof fn != 'function'
      throw 'Must supply a function, \'' + typeof fn + '\' given instead'
    if registry.indexOf(fn) == -1
      registry.push fn
    return

  @registerAndInvoke = (fn) ->
    fn @get()
    @register fn
    return

  @deregister = (fn) ->
    registry.splice registry.indexOf(fn), 1
    return

  @reset = ->
    registry = []
    @set initialValue or null
    return

  @setCreateFunction = (fn) ->
    @createFunction = fn
    return

  @setUpdateFunction = (fn) ->
    @updateFunction = fn
    return

  @setRemoveFunction = (fn) ->
    @removeFunction = fn
    return

  @create = (newValue) ->
    @createFunction newValue, internal
    return

  @update = (newValues) ->
    @updateFunction newValues, internal
    return

  @remove = (id) ->
    @removeFunction id, internal
    return

  internal =
    currentValue: initialValue or null
    keys: (object) ->
      if !object
        return null
      result = []
      for k of object
        if object.hasOwnProperty(k)
          result.push k
      result
    emit: (value, updatedKeys) ->
      i = 0
      while i < registry.length
        try
          registry[i] value, updatedKeys
        catch e
        i++
      value
  this
