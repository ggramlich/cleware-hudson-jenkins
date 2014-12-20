{CoolBeans, expect} = require '../specHelper'

describe 'normalize colors', ->
  beforeEach ->
    @container = new CoolBeans require '../../production-module.coffee'

    @normalizeColors = @container.get 'normalizeColors'
    @isNormalizedTo = (input, expected) ->
      expect(@normalizeColors input).to.deep.equal expected

  it 'normalizes single color', ->
    @isNormalizedTo 'red', {red: on, yellow: off, green: off}
    @isNormalizedTo ['red'], {red: on, yellow: off, green: off}

  it 'normalizes object color', ->
    @isNormalizedTo {job1: 'red'}, {red: on, yellow: off, green: off}

  it 'normalizes duplicate colors', ->
    @isNormalizedTo ['red', 'red'], {red: on, yellow: off, green: off}

  it 'removes unknown colors', ->
    @isNormalizedTo 'disabled', {red: off, yellow: off, green: off}

  it 'translates blue to green', ->
    @isNormalizedTo 'blue', {red: off, yellow: off, green: on}

  it 'keeps green as is', ->
    @isNormalizedTo 'green', {red: off, yellow: off, green: on}

  it 'normalizes multiple colors', ->
    @isNormalizedTo ['yellow', 'green'], {red: off, yellow: on, green: on}

  it 'normalizes anime color', ->
    @isNormalizedTo 'yellow_anime', {red: off, yellow: 'a', green: off}
    @isNormalizedTo 'blue_anime', {red: off, yellow: off, green: 'a'}

  it 'normalizes with anime color taking precedence over normal color', ->
    @isNormalizedTo ['yellow', 'yellow_anime'], {red: off, yellow: 'a', green: off}
    @isNormalizedTo ['green', 'blue_anime'], {red: off, yellow: off, green: 'a'}
    @isNormalizedTo ['green_anime', 'blue'], {red: off, yellow: off, green: 'a'}
