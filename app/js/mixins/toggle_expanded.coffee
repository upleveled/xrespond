
module.exports = ToggleExpanded =
  toggleExpanded: (e) ->
    @setState expanded: !@state.expanded
