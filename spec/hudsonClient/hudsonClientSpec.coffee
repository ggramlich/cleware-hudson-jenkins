{CoolBeans, expect} = require '../specHelper'

describe 'hudson client', ->
  JSON = 'Content-Type': 'application/json'
  SERVER = 'https://myserver'

  beforeEach ->
    container = new CoolBeans
      nock: module: 'nock'
      rest: module: 'restler'
      _: module: 'lodash'
      hudsonClient:
        module: 'lib/hudsonClient'
        autowire: true

    nock = container.get 'nock'
    @nock = nock(SERVER)
    @hudsonClient = container.get 'hudsonClient'

  it 'lists all jobs', (done) ->
    @nock.get('/api/json')
      .reply(200, {jobs: ['a', 'b']}, JSON)

    @hudsonClient(SERVER).listJobs (result) ->
      expect(result).to.deep.equal ['a', 'b']
      done()

  it 'lists the jobs in a view', (done) ->
    @nock.get('/view/All/api/json')
      .reply(200, {jobs: ['a', 'b']}, JSON)

    @hudsonClient(SERVER).listJobsInView 'All', (result) ->
      expect(result).to.deep.equal ['a', 'b']
      done()

  it 'reads the color of a job', (done) ->
    @nock.get('/job/myjob/api/json?tree=name,color')
      .reply(200, {name: 'myjob', color: 'blue'}, JSON)

    @hudsonClient(SERVER).colorOfJob 'myjob', (result) ->
      expect(result).to.equal 'blue'
      done()

  it 'handles trailing / in server url gracefully', (done) ->
    @nock.get('/job/myjob/api/json?tree=name,color')
      .reply(200, {name: 'myjob', color: 'blue'}, JSON)

    @hudsonClient(SERVER + '/').colorOfJob 'myjob', (result) ->
      expect(result).to.equal 'blue'
      done()

  it 'reads the color of jobs in a view', (done) ->
    jobsResponse = jobs: [
      {name: 'job1', color: 'blue'}
      {name: 'job2', color: 'disabled'}
    ]
    @nock.get('/view/All/api/json?tree=jobs[name,color]')
    .reply(200, jobsResponse, JSON)

    @hudsonClient(SERVER).colorsInView 'All', (result) ->
      expect(result).to.deep.equal {job1: 'blue', job2: 'disabled'}
      done()

