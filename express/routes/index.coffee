module.exports = (lights) ->
  index: (req, res) ->
    res.render "index",
      title: "Express"

  lights: (req, res) ->
    red = (req.param 'red')?
    yellow = (req.param 'yellow')?
    green = (req.param 'green')?
    console.log 'red:    ' + red
    console.log 'yellow: ' + yellow
    console.log 'green:  ' + green
    lights.red red, ->
      lights.yellow yellow, ->
        lights.green green

    res.redirect '/'