XrespondDefaults = require '../lib/defaults'

fakeStorage =
  getItem: (_) -> null
  setItem: (_) -> null
  save:    (_) -> null

if localStorage?
  localStorage = window.localStorage
else
  localStorage = fakeStorage

module.exports = XrespondLocal =
  defaultState: ->
    devices: XrespondDefaults.devices()
    url:     XrespondDefaults.url
    stretch: false

  load: ->
    JSON.parse(localStorage.getItem('xrespond')) or @defaultState()

  save: (local) ->
    localStorage.setItem 'xrespond', JSON.stringify(local)

  attr: (attr_name) ->
    @load()[attr_name]

  updateAttr: (attr_name) ->
    (data) =>
      local = @load()
      local[attr_name] = data
      @save local
