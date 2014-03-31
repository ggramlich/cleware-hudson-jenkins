os = require 'os'
async = require 'async'

cliExecutor = require('../lib/cliExecutor')(require 'child_process')
cleware = require('../lib/lights/cleware')(os.platform())
lights = require('../lib/lights')(cleware, cliExecutor).for(407571)

createCommands = require './test2.1.coffee'
lightCommand = (light) ->
  (state, delay) ->
    command: (callback) -> lights[light] state, callback
    delay: delay

commands = createCommands(
  lightCommand 'red'
  lightCommand 'yellow'
  lightCommand 'green'
  lightCommand 'all'
)

execCommand = (index) ->
  unless index >= commands.length
    console.dir index
    commands[index]().command setTimeout((-> execCommand(index + 1)), commands[index]().delay)

execCommand(0)
