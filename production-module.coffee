module.exports =
  os:
    module: 'os'
  rest:
    module: 'restler'
  platform:
    factoryBean: 'os'
    factoryMethod: 'platform'
  child_process:
    module: 'child_process'
  _:
    module: 'lodash'
  cliExecutor:
    module: 'lib/cliExecutor'
    autowire: true
  lights:
    module: 'lib/lights'
    autowire: true
  cleware:
    module: 'lib/lights/cleware'
    autowire: true
  hudsonClient:
    module: 'lib/hudsonClient'
    autowire: true
