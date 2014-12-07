CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'
conf = container.get('conf')

lights = container.get('lights').for conf.get 'serialno'

lights.red on, ->
  lights.green on, ->
    lights.yellow on, ->
      setTimeout (-> lights.all off), 1000

