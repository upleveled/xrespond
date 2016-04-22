
var XrespondSource = React.createClass({
  mixins: [MessageBusMixin],
  getInitialState: function() {
    return {url: Xrespond.local.attr('url')}
  },
  handleSubmit: function(e) {
    e.preventDefault()
    source_value = this.refs.source.value.trim()

    this.publish('sourceSubmit', this.assert_prefix(source_value))
  },
  assert_prefix: function(url) {
    return url.match(/^http/) || url == '' ? url : 'http://' + url
  },
  render: function() {
    return (
      <form className="source__wrap" onSubmit={this.handleSubmit}>
        <input className="text-input text-input--medium source__text-input" placeholder="Enter URL" ref="source" defaultValue={this.state.url} onChange={this.handleChange} />
        <button className="button button--medium button--submit source__button">Respond</button>
      </form>
    )
  }
})
