CoolBeans = require 'CoolBeans'
expect = require('chai').expect
sinon = require 'sinon'

describe 'hudsonClient', ->
  JSON = 'Content-Type': 'application/json'

  beforeEach ->
    @container = new CoolBeans
      nock: module: 'nock'
      rest: module: 'restler'
      hudsonClient:
        module: 'lib/hudsonClient'
        autowire: true
    @nock = @container.get 'nock'

  it 'lists the jobs', (done) ->
    @nock('https://myserver')
      .get('/view/All/api/json')
      .reply(200, {jobs: ['a', 'b']}, JSON)

    hudsonClient = @container.get 'hudsonClient'
    hudsonClient.listJobs 'https://myserver/view/All', (result) ->
      expect(result).to.deep.equal ['a', 'b']
      done()

  it 'reads the color of a job', (done) ->
    @nock('https://myserver')
      .get('/job/myjob/api/json')
      .reply(200, {color: 'blue'}, JSON)

    hudsonClient = @container.get 'hudsonClient'
    hudsonClient.color 'https://myserver', 'myjob', (result) ->
      expect(result).to.equal 'blue'
      done()
