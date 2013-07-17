CoolBeans = require 'CoolBeans'
container = new CoolBeans require './production-module'

hudsonClient = container.get('hudsonClient')
#hudsonClient.listJobs 'https://www.jenkins-ci.org/view/All', console.log
hudsonClient.color 'https://www.jenkins-ci.org/', 'tools_maven-hpi-plugin-maven-2.x', console.log
