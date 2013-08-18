CoolBeans = require 'CoolBeans'
container = new CoolBeans require './production-module'

hudsonClient = container.get('hudsonClient')
#hudsonClient('https://www.jenkins-ci.org').listJobs 'All', console.log
hudsonClient('https://www.jenkins-ci.org/').color 'tools_maven-hpi-plugin-maven-2.x', console.log
