jest.disableAutomock()

React     = require 'react'
ReactDOM  = require 'react-dom'
TestUtils = require 'react-addons-test-utils'
Source    = require '../../app/js/components/source'

describe 'Source', =>
  it 'renders', =>
    source = TestUtils.renderIntoDocument(<Source />)
    sourceNode = ReactDOM.findDOMNode(source)

    expect(sourceNode.textContent).toEqual('Load URL')
