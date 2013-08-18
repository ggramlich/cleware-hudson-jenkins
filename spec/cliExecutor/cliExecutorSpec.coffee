{CoolBeans, expect, sinon} = require '../specHelper'

describe 'cliExecutor', ->
  beforeEach ->
    @child_process = execFile: sinon.spy()
    @container = new CoolBeans
      cliExecutor:
        module: 'lib/cliExecutor'
        constructorArgs:
          child_process: value: @child_process
    @cliExecutor = @container.get 'cliExecutor'


  it 'executes a command', ->
    callback = ->
    command = 'dummy'
    args = [1]
    options = {'x'}
    @cliExecutor {command, args, options}, callback
    expect(@child_process.execFile.calledWithExactly command, args, options, callback).to.be.true

  it 'executes a command with default args and options', ->
    callback = ->
    command = 'dummy'
    @cliExecutor {command}, callback
    expect(@child_process.execFile.calledWithExactly command, [], {}, callback).to.be.true