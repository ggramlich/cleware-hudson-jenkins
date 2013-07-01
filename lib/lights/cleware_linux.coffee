module.exports = (serialno, color, state) ->
  command: 'clewarecontrol'
  options: ['-d', serialno, '-c', '1', '-as', color, if state then 1 else 0]
