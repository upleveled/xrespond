# A utility for checking if a click event has occured locally within a React component, or outside of it
# Useful for implementing "hide dropdown when user clicks elsewhere" style functionality

# Usage example:
#
#  componentDidMount: ->
#    document.addEventListener 'click', @documentClickHandler
#
#  componentWillUnmount: ->
#    document.removeEventListener 'click', @documentClickHandler
#
#  documentClickHandler: (evt) ->
#    if ClickSource.isGlobal(evt, @) then @handleBlur()

ReactDOM = require 'react-dom'

module.exports = ClickSource =
  isGlobal: (evt, component) ->
    # https://github.com/facebook/react/issues/579
    localNode = ReactDOM.findDOMNode(component)
    source = evt.target
    found = false
    while source.parentNode
      # if source=local then @event came from "somewhere" inside, so not a global click
      found = (source == localNode)
      return false if found
      source = source.parentNode

    return true # not found: genuine outside event.
