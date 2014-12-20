{CoolBeans, expect} = require '../specHelper'

getCleware = (platform) ->
  container = new CoolBeans
    cleware:
      module: 'lib/lights/cleware'
      constructorArgs:
        platform: value: platform
  container.get('cleware')

describe 'linux cleware', ->
  beforeEach ->
    @cleware = getCleware 'linux'

  it 'should create the correct command for red on', ->
    command = @cleware.command(123, 0, on)
    expect(command).to.deep.equal {
      command: 'clewarecontrol',
      args: [ '-d', '123', '-c', '1', '-as', '0', '1' ]
    }

  it 'should create the correct command for green off', ->
    command = @cleware.command(123, 2, off)
    expect(command).to.deep.equal {
      command: 'clewarecontrol',
      args: [ '-d', '123', '-c', '1', '-as', '2', '0' ]
    }

  it 'should create the correct command for color-states', ->
    command = @cleware.command(123, {0: off, 1: on, 2: on})
    expect(command).to.deep.equal {
      command: 'clewarecontrol',
      args: [ '-d', '123', '-c', '1', '-as', '0', '0', '-as', '1', '1', '-as', '2', '1' ]
    }

describe 'windows cleware', ->
  beforeEach ->
    @cleware = getCleware 'win32'

  it 'should create the correct command for red on', ->
    command = @cleware.command(123, 0, on)
    expect(command).to.deep.equal {
      command: 'USBswitchCmd.exe',
      args: [ '-n', '123', '1', '-#', '0' ]
    }

  it 'should create the correct command for green off', ->
    command = @cleware.command(123, 2, off)
    expect(command).to.deep.equal {
      command: 'USBswitchCmd.exe',
      args: [ '-n', '123', '0', '-#', '2' ]
    }

  it 'should create the correct command for color-states', ->
    command = @cleware.command(123, {0: off, 1: on, 2: on})
    expect(command).to.deep.equal {
      command: 'USBswitchCmd.exe',
      args: [ '-n', '123', 'O', 'Y', 'G' ]
    }
