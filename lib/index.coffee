os = require 'os'

cliExecutor = require('./cliExecutor')(require 'child_process')
cleware = require('./lights/cleware')(os.platform())
lights = require('./lights')(cleware, cliExecutor).for(407571)

lights.red on, ->
  lights.green on, ->
    lights.yellow on, ->
      setTimeout (-> lights.all off), 1000

