CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'

lights = container.get('lights').for 407571

createCommands = require './test2.1.coffee'
lightCommand = (color) ->
  (state, delay) ->
    (delayedCallback) -> lights[color] state, setTimeout(delayedCallback, delay)

commands = createCommands(
  lightCommand 'red'
  lightCommand 'yellow'
  lightCommand 'green'
  lightCommand 'all'
)

execCommandAtIndex = (index) ->
  unless index >= commands.length
    command = commands[index]
    command -> execCommandAtIndex index + 1

execCommandAtIndex 0
