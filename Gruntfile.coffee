module.exports = (grunt) ->
  # task
  grunt.initConfig
    dir: 
      src: "src"
      dest: "dist"
      jade: "jade"
      coffee: "coffee"
      js: "js"
    pkg: grunt.file.readJSON "package.json"

    bower:
      install: 
        options:
          targetDir: "<%= dir.dest %>/lib"
          layout: "byType"
          install: true
          verbose: false
          cleanBowerDir: true

    jade:
      markdown:
        options:
          pretty: true
        expand: true
        cwd: '<%= dir.src %>/markdown/<%= dir.jade %>' 
        src: '**/*.jade'
        dest: '<%= dir.dest %>/markdown/'
        ext: '.html'

    coffee:
      options:
        bare: true
      markdown:
        expand: true
        cwd: '<%= dir.src %>/markdown/<%= dir.coffee %>'
        src: '**/**/*.coffee'
        dest: '<%= dir.dest %>/markdown/<%= dir.js %>'
        ext: '.js'

    watch:
      jade:
        files: '<%= dir.src %>/markdown/**/*.jade'
        tasks: 'jade:markdown'
      coffee:
        files: ['<%= dir.src %>/markdown/**/**/*.coffee','<%= dir.src %>/markdown/**/*.coffee']
        tasks: 'coffee:markdown'
      bower:
        files: 'bower.json',
        tasks: 'bower:install'

    # web server setting
    connect:
      site:
        options:
          hostname: "localhost"
          port: 8000
          base: "<%= dir.dest %>"


  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"

  grunt.registerTask 'default', ['bower','jade','coffee','connect','watch']