os = require 'os'
if os.platform() is 'linux'
  clewareParams = require './lights/cleware_linux'
else
  clewareParams = require './lights/cleware_win'


lights = require('./lights')(407571, clewareParams)

lights.red on, ->
  lights.green on, ->
    lights.yellow on, ->
      setTimeout (-> lights.all off), 1000

