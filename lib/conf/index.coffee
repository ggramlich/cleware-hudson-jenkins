module.exports = (nconf, configFile) ->
  nconf.argv().env().file configFile.path
