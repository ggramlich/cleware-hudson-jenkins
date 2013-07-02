os = require 'os'
if os.platform() is 'linux'
  clewareParams = require '../../lib/lights/cleware_linux'
else
  clewareParams = require '../../lib/lights/cleware_win'


lights = require('../../lib/lights')(407571, clewareParams)

exports.index = (req, res) ->
  res.render "index",
    title: "Express"

exports.lights = (req, res) ->
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