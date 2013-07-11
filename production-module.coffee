module.exports =
  os:
    module: 'os'
  platform:
    factoryBean: 'os'
    factoryMethod: 'platform'
  child_process:
    module: 'child_process'
  cliExecutor:
    module: 'lib/cliExecutor'
    autowire: true
  lights:
    module: 'lib/lights'
    autowire: true
  cleware:
    module: 'lib/lights/cleware'
    autowire: true
