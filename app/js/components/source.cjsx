React    = require 'react'
Xrespond = require('../scripts/xrespond')

module.exports = XrespondSource = React.createClass
  mixins: [ MessageBusMixin ]
  getInitialState: ->
    url: Xrespond.local.attr('url')
  handleSubmit: (e) ->
    e.preventDefault()
    source_value = @refs.source.value.trim()
    @publish 'sourceSubmit', @assert_prefix(source_value)

  assert_prefix: (url) ->
    if url.match(/^http/) or url == '' then url else 'http://' + url

  render: ->
    <form className="source__wrap" onSubmit={@handleSubmit}>
      <input className="text-input text-input--medium source__text-input" placeholder="Enter URL" ref="source" defaultValue={@state.url} onChange={@handleChange} />
      <button className="button button--medium button--submit source__button">Respond</button>
    </form>
