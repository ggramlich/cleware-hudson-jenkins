CoolBeans = require 'CoolBeans'
expect = require('chai').expect
sinon = require 'sinon'

describe 'lights', ->
  beforeEach ->
    @cliExecutor = sinon.spy((arg, callback) -> callback())
    @cleware = command: sinon.stub()
    @container = new CoolBeans
      lights:
        module: 'lib/lights'
        constructorArgs:
          cliExecutor: value: @cliExecutor
          cleware: value: @cleware
    @lights = @container.get 'lights'
    @callback = ->
    @commandDummy = {"dummy"}


  it 'should call the cliExecutor with the cleware command for red', ->
    @cleware.command.withArgs(123, 0, on).returns @commandDummy

    @lights.for(123).red on, @callback

    expect(@cliExecutor.calledWith @commandDummy, @callback).to.be.true

  it 'should call the cliExecutor with the cleware command for yellow', ->
    @cleware.command.withArgs(123, 1, on).returns @commandDummy

    @lights.for(123).yellow on, @callback

    expect(@cliExecutor.calledWith @commandDummy, @callback).to.be.true

  it 'should call the cliExecutor with the cleware command for green', ->
    @cleware.command.withArgs(123, 2, on).returns @commandDummy

    @lights.for(123).green on, @callback

    expect(@cliExecutor.calledWith @commandDummy, @callback).to.be.true

  it 'should call the cliExecutor with the cleware command for all', ->
    commandDummyRed = ->
    commandDummyYellow = ->
    commandDummyGreen = ->
    @cleware.command.withArgs(123, 0, on).returns commandDummyRed
    @cleware.command.withArgs(123, 1, on).returns commandDummyYellow
    @cleware.command.withArgs(123, 2, on).returns commandDummyGreen

    @lights.for(123).all on, @callback

    expect(@cliExecutor.calledWith commandDummyRed).to.be.true
    expect(@cliExecutor.calledWith commandDummyYellow).to.be.true
    expect(@cliExecutor.calledWith commandDummyGreen, @callback).to.be.true
