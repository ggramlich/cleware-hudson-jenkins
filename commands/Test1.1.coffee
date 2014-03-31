module.exports = (red, yellow, green, all) ->
  commands=[]
  commands.push(->green(on,1000))
  commands.push(->red(on,13000))
  commands.push(->green(off,5000))
  commands.push(->yellow(on,4000))
  commands.push(->yellow(off,5000))
  commands.push(->green(on,15000))
  commands.push(->green(off,0))
  commands
