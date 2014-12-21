# intervals in milliseconds
REQUEST_HUDSON_INTERVAL = 30000
BLINK_INTERVAL = 1000

currentColors = {}
blinkState = off

module.exports = (hudsonClient, lights, conf, _, normalizeColors) ->
  lightsControl = lights.for conf.get 'serialno'
  server = conf.get 'server'
  type = conf.get 'type'

  hudson = hudsonClient(server)

  getColors = if type is 'job' then hudson.colorOfJob else hudson.colorsInView
  updateColors = (callback = ->) ->
    getColors (conf.get 'name'), (colors) ->
      currentColors = normalizeColors colors
      callback()

  updateLights = ->
    console.dir currentColors

    colorStates = {}
    for color, value of currentColors
      colorStates[color] = if value is 'a' then blinkState else value

    lightsControl.states colorStates, ->
      blinkState = not blinkState
      setTimeout updateLights, BLINK_INTERVAL

  start: ->
    setInterval updateColors, REQUEST_HUDSON_INTERVAL
    updateColors updateLights
