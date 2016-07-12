jest.disableAutomock()

React     = require 'react'
ReactDOM  = require 'react-dom'
TestUtils = require 'react-addons-test-utils'
Source    = require '../app/js/components/source'
Frame     = require '../app/js/components/frame'

describe 'Entering source URL', =>
  it 'loads URL on Frame components', =>
    source = TestUtils.renderIntoDocument(<Source />)
    frame  = TestUtils.renderIntoDocument(<Frame />)

    sourceNode = ReactDOM.findDOMNode(source)
    frameNode = ReactDOM.findDOMNode(frame)

    enteredUrl = 'mario.net.au'
    expectedUrl = 'http://mario.net.au'

    source.refs.source.value = enteredUrl
    TestUtils.Simulate.submit(sourceNode)
    # TestUtils.Simulate.keyDown(sourceNode, {key: "Enter", keyCode: 13, which: 13})

    # console.log source.state
    # console.log frame.state
    # console.log frameNode

    expect(frame.state.url).toEqual expectedUrl
