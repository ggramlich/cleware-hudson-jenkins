module.exports = (child_process) ->
  (command, callback) ->
    console.log 'executing ' + command.command + ", " + command.args
    child_process.execFile command.command, command.args ? [], command.options ? {}, callback
