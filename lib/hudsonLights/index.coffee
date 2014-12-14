module.exports = (hudsonClient, lights, conf) ->
  lightsControl = lights.for conf.get 'serialno'

  start: ->
    lightsControl.red on, ->
      lightsControl.green on, ->
        lightsControl.yellow on, ->
          setTimeout (-> lightsControl.all off), 1000
