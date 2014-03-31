CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'

lights = container.get('lights').for 407571

createCommands = require './test2.1.coffee'
lightCommand = (color) ->
  (state, delay) ->
    execute: (callback) -> lights[color] state, callback
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
    commands[index].execute setTimeout((-> execCommand(index + 1)), commands[index].delay)

execCommand(0)
