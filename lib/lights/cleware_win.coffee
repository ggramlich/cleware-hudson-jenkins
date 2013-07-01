module.exports = (serialno, color, state) ->
  command: 'USBswitchCmd.exe'
  options: ['-n', serialno, (if state then 1 else 0), '-#', color]
