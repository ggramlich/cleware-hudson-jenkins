CoolBeans = require 'CoolBeans'
container = new CoolBeans require './production-module'

hudsonClient = container.get('hudsonClient')
hudsonClient('https://www.jenkins-ci.org/').colorOfJob 'tools_maven-hpi-plugin-maven-2.x', console.log
hudsonClient('https://www.jenkins-ci.org/').colorsInView 'All', console.log
