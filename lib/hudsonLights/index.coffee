# interval in seconds
REQUEST_HUDSON_INTERVAL = 20

currentColors = {}
lastLights = {}
blinkState = off

module.exports = (hudsonClient, lights, conf, _, normalizeColors) ->
  lightsControl = lights.for conf.get 'serialno'
  server = conf.get 'server'
  type = conf.get 'type'

  hudson = hudsonClient(server)

  if type is 'job'
    job = conf.get 'name'
    getColors = (callback) ->
      hudson.colorOfJob job, callback
  else
    view = conf.get 'name'
    getColors = (callback) ->
      hudson.colorsInView view, callback

  updateColors = (colors) ->
    currentColors = normalizeColors colors

  updateLights = ->
    console.dir currentColors
    console.log blinkState

    commands = for color, value of currentColors
      onOff = if value is 'a' then blinkState else value
      if (not lastLights[color]? or lastLights[color] isnt onOff)
        do (onOff, color) ->
          (callback) ->
            lastLights[color] = onOff
            lightsControl[color] onOff, callback
      else (callback) -> callback()

    commands.push ->
      blinkState = not blinkState
      setTimeout updateLights, 800

    runCommand = (index) ->
      # if running on the last command, the callback is ignored.
      commands[index](-> runCommand(index + 1))

    runCommand(0)

  start: ->
    setInterval (-> getColors updateColors), REQUEST_HUDSON_INTERVAL * 1000
    getColors (colors) ->
      updateColors colors
      updateLights()
