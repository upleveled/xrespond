
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
      <div className="source__wrap">
        <form onSubmit={this.handleSubmit}>
            <input ref="source" className="text-input text-input--medium source__text-input" placeholder="Enter URL" defaultValue={this.state.url} onChange={this.handleChange} />
            <button className="button button--medium button--submit source__button" type="submit">Respond</button>
        </form>
      </div>
    )
  }
})
