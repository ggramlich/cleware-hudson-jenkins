CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'

lights = container.get('lights').for 407571

lights.red on, ->
  lights.green on, ->
    lights.yellow on, ->
      setTimeout (-> lights.all off), 1000

