COLORS = ['R', 'Y', 'G']
onOff = (state) -> if state then '1' else '0'

module.exports = (platform) ->
  command: (serialno, colors, state) ->
    switch platform
      when 'linux'
        command = 'clewarecontrol'
        args = ['-d', "#{serialno}", '-c', '1']
        if state?
          args = args.concat ['-as', "#{colors}", onOff state]
        else
          for color, state of colors
            args = args.concat ['-as', "#{color}", onOff state]
      else
        command = 'USBswitchCmd.exe'
        args = ['-n', "#{serialno}"]
        if state?
          args = args.concat [onOff(state), '-#', "#{colors}"]
        else
          args = args.concat ['O']
          for color, state of colors
            if state
              args.push COLORS[color]

    {command, args}
