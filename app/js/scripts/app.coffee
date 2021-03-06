require 'what-input'
svg4everybody = require 'svg4everybody'

React        = require 'react'
ReactDOM     = require 'react-dom'

MessageBus   = require '../lib/message_bus'
Devices      = require '../components/devices'
Source       = require '../components/source'
ShareToggle  = require '../components/share_toggle'
DeviceHeight = require '../components/device_height'

require('./local')
Xrespond = require('./xrespond')

MessageBus.subscribe Xrespond.local, 'sourceSubmit', Xrespond.local.updateAttr('url')
MessageBus.subscribe Xrespond.local, 'deviceHeight', Xrespond.local.updateAttr('stretch')

mount = (component, id) -> ReactDOM.render React.createElement(component), document.getElementById(id)

document.addEventListener 'DOMContentLoaded', (event) ->
  svg4everybody()

  mount Devices, 'main'
  mount Source, 'source-url'
  mount ShareToggle, 'share-toggle'
  mount DeviceHeight, 'device-height'
