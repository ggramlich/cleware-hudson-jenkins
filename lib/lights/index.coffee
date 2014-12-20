COLORS =
  red: 0
  yellow: 1
  green: 2

module.exports = (cleware, cliExecutor) ->
  for: (serialno) ->
    callCleware = (color, state, callback) ->
      command = cleware.command serialno, color, state
      cliExecutor command, callback

    red = (state, callback) -> callCleware(0, state, callback)
    yellow = (state, callback) -> callCleware(1, state, callback)
    green = (state, callback) -> callCleware(2, state, callback)
    all = (state, callback) ->
      red state, ->
        yellow state, ->
          green state, callback
    states = (colors, callback) ->
      colorStates = {}
      for color, state of colors
        colorStates[COLORS[color]] = state

      command = cleware.command serialno, colorStates
      cliExecutor command, callback

    {red, green, yellow, all, states}
