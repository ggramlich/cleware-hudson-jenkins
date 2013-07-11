module.exports = (platform) ->
  switch platform
    when 'linux'
      command: (serialno, color, state) ->
        command: 'clewarecontrol'
        args: ['-d', "#{serialno}", '-c', '1', '-as', "#{color}", if state then '1' else '0']
    else
      command: (serialno, color, state) ->
        command: 'USBswitchCmd.exe'
        args: ['-n', "#{serialno}", (if state then '1' else '0'), '-#', "#{color}"]
