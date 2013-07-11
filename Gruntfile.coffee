module.exports = (grunt) ->

  # See http://www.jshint.com/docs/#strict
  "use strict"

  # Project configuration.
  grunt.initConfig

  # Metadata.
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" + " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

  # Task configuration.
#    watch:
#      files: ["**/*.js", "**/*.json", ".jshintrc", "!node_modules/**/*.js", "!node_modules/**/*.json", "!public/**/*.js", "!public/**/*.json", "!frontendtests/lib/**/*.js", "!frontendtests/lib/**/*.json", "**/*.jade"]
#      tasks: ["default"]

    "mocha-hack":
      options:
        globals: ["should"]
        timeout: 3000
        ignoreLeaks: false
        ui: "bdd"
        reporter: "spec"

      all:
        src: ["spec/**/*.coffee"]

  # These plugins provide necessary tasks.
#  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-mocha-hack"

  # Default task.
  grunt.registerTask "default", ["mocha-hack"]

  # Travis-CI task
  grunt.registerTask "travis", ["default"]