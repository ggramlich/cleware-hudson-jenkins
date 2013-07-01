child_process = require 'child_process'

class Cleware
  constructor: (@serialno, @clewareParams) ->

  cleware: (color, state, callback) =>
    console.log "Switch #{@serialno} color #{color} to #{state}"
    spawned = @spawnCleware(color, state)

    spawned.stdout.on 'data', (data) ->
      console.log 'stdout: ' + data

    spawned.stderr.on 'data', (data) ->
      console.log 'stderr: ' + data

    spawned.on 'close', (code) ->
      console.log 'child process exited with code ' + code
      callback() if callback?

  red: (state, callback) =>
    @cleware 0, state, callback

  yellow: (state, callback) =>
    @cleware 1, state, callback

  green: (state, callback) =>
    @cleware 2, state, callback

  all: (state, callback) =>
    @red state, =>
      @yellow state, =>
        @green state, callback

  spawnCleware: (color, state) =>
    params = @clewareParams(@serialno, color, state)
    child_process.spawn(params.command, params.options, { stdio: 'pipe' })

dummyCleware = (serialno, color, state) ->
  command: 'echo'
  options: ['serialno', serialno, 'color', color, 'state', state]

module.exports = (serialno, clewareParams = dummyCleware) -> new Cleware(serialno, clewareParams)
