module.exports = (red, yellow, green, all) ->
  commands=[]
  commands.push(->red(on,2000))
  commands.push(->yellow(on,3000))
  commands.push(->all(off,0))
  commands.push(->green(on,2000))
  commands.push(->red(on,2000))
  commands.push(->red(off,0))
  commands
