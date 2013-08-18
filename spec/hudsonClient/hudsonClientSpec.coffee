CoolBeans = require 'CoolBeans'
expect = require('chai').expect
sinon = require 'sinon'

describe 'hudsonClient', ->
  JSON = 'Content-Type': 'application/json'
  SERVER = 'https://myserver'

  beforeEach ->
    container = new CoolBeans
      nock: module: 'nock'
      rest: module: 'restler'
      hudsonClient:
        module: 'lib/hudsonClient'
        autowire: true

    nock = container.get 'nock'
    @nock = nock(SERVER)
    @hudsonClient = container.get 'hudsonClient'

  it 'lists the jobs', (done) ->
    @nock.get('/view/All/api/json')
      .reply(200, {jobs: ['a', 'b']}, JSON)

    @hudsonClient(SERVER).listJobs 'All', (result) ->
      expect(result).to.deep.equal ['a', 'b']
      done()

  it 'reads the color of a job', (done) ->
    @nock.get('/job/myjob/api/json')
      .reply(200, {color: 'blue'}, JSON)

    @hudsonClient(SERVER).color 'myjob', (result) ->
      expect(result).to.equal 'blue'
      done()

  it 'handles trailing / in server url gracefully', (done) ->
    @nock.get('/job/myjob/api/json')
      .reply(200, {color: 'blue'}, JSON)

    @hudsonClient(SERVER + '/').color 'myjob', (result) ->
      expect(result).to.equal 'blue'
      done()
