module.exports = function(grunt) {
 
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    concat: {      
      // assets_js: {
      //   options: {
      //     separator: ';'
      //   },
      //   src: ['src/**/*.js'],
      //   // dest: 'sixify/js/<%= pkg.name %>.js'
      //   dest: 'dist/_bower.js'
      // }, 
      assets_css: {
        src: ['dist/_bower.css', 'src/*.css' ],
        dest: 'sixify/css/<%= pkg.name %>.css'
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n',
        //mangle: false
        mangle: {
          except: ['jQuery']
        }
      },
      dist: {
        files: {
          'sixify/js/<%= pkg.name %>.min.js': ['dist/_bower.js', 'src/*.js'],
        }
      }
    },
    cssmin: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      },
      dist: {
        files: {
          'sixify/css/<%= pkg.name %>.min.css': ['dist/_bower.css', 'dist/*.css'],
        }
      }
    },
    qunit: {
      files: ['test/**/*.html']
    },
    jshint: {
      files: ['gruntfile.js', 'src/**/*.js', 'test/**/*.js'],
      options: {
        // options here to override JSHint defaults
        globals: {
          jQuery: true,
          console: true,
          module: true,
          document: true
        }
      }
    },
    watch: {
      files: ['src/*'],
      tasks: ['assets']
    },
    // concat everything from bower_components
	  bower_concat: {
  	  all: {
  	    dest: 'dist/_bower.js',
  	    cssDest: 'dist/_bower.css',
  	    // exclude: [
  	    //   'jquery',
  	    //   'modernizr'
  	    // ],
  	    dependencies: {
          'bootstrap': 'jquery',
          'angular': 'jquery'
  	      // 'underscore': 'jquery',
  	      // 'backbone': 'underscore',
  	      // 'jquery-mousewheel': 'jquery'
  	    },
  	    bowerOptions: {
  	      relative: false
  	    }
  	  }
    },
    copy: {
      main: {
        files: [
          // includes files within path
          {src: 'bower_components/bootstrap/dist/css/bootstrap.css.map', dest: 'sixify/css/bootstrap.css.map'},
          {src: 'bower_components/bootstrap/dist/css/bootstrap-theme.css.map', dest: 'sixify/css/bootstrap-theme.css.map'}
        ]
      }
  	}
  });
 
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-bower-concat');
 
  grunt.registerTask('test', ['jshint', 'qunit']); 
  grunt.registerTask('default', ['bower_concat', 'concat', 'uglify', 'copy']); 
};
