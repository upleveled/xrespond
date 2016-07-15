XrespondDefaults = require '../lib/defaults'
MessageBus       = require '../lib/message_bus'
url              = require 'url'

fakeStorage =
  getItem: (_) -> null
  setItem: (_) -> null
  save:    (_) -> null

if window.localStorage?
  localStorage = window.localStorage
else
  localStorage = fakeStorage

module.exports = XrespondLocal =
  defaultState: ->
    devices: XrespondDefaults.devices()
    url:     XrespondDefaults.url
    stretch: false

  load: ->
    @shared() or JSON.parse(localStorage.getItem('xrespond')) or @defaultState()

  save: (local) ->
    return if @shared()

    localStorage.setItem 'xrespond', JSON.stringify(local)
    MessageBus.publish 'settingsSave', local

  attr: (attr_name) ->
    @load()[attr_name]

  updateAttr: (attr_name) ->
    (data) =>
      local = @load()
      local[attr_name] = data
      @save local

  shared: ->
    url_parts = url.parse(window.location.href, true)
    query = url_parts.query
    if query.share? then JSON.parse(atob(query.share)) else false
