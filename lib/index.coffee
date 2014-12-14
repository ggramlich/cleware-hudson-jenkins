CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'

hudsonLights = container.get 'hudsonLights'
hudsonLights.start()
