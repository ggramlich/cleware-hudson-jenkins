CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'

lights = container.get('lights').for 407571

createCommands = require './test2.1.coffee'
lightCommand = (color) ->
  (state, delay) ->
    execute: (delayedCallback) -> lights[color] state, setTimeout(delayedCallback, delay)

commands = createCommands(
  lightCommand 'red'
  lightCommand 'yellow'
  lightCommand 'green'
  lightCommand 'all'
)

execCommand = (index) ->
  unless index >= commands.length
    console.dir index
    commands[index].execute (-> execCommand(index + 1))

execCommand(0)
