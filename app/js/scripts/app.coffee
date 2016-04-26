require 'what-input'
require '../lib/base_store'
require '../mixins/message_bus'
require '../mixins/toggle_expanded'

Devices      = require '../components/devices'
Source       = require '../components/source'
DeviceHeight = require '../components/device_height'

require('./defaults')
require('./local')
Xrespond = require('./xrespond')

MessageBus.subscribe Xrespond.local, 'sourceSubmit', Xrespond.local.updateAttr('url')
MessageBus.subscribe Xrespond.local, 'deviceHeight', Xrespond.local.updateAttr('stretch')

mount = (component, id) -> ReactDOM.render React.createElement(component), document.getElementById(id)

document.addEventListener 'DOMContentLoaded', (event) ->
  mount Devices, 'main'
  mount Source, 'source'
  mount DeviceHeight, 'device-height'
