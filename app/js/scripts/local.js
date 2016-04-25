XrespondDefaults = require('./defaults')

XrespondLocal = function() {
  var that = this
  this.defaultState = function() {
    return {
      devices: XrespondDefaults.devices(),
      url:     XrespondDefaults.url,
      stretch: false
    }
  }
  this.load = function() {
    return JSON.parse(localStorage.getItem('xrespond')) || that.defaultState()
  }
  this.save = function(local) {
    localStorage.setItem('xrespond', JSON.stringify(local))
  }
  this.attr = function(attr_name) {
    return that.load()[attr_name]
  }
  this.updateAttr = function(attr_name) {
    return function(data) {
      var local = that.load()
      local[attr_name] = data
      that.save(local)
    }
  }
  return this
}
