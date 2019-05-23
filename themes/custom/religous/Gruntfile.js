module.exports = function (grunt) {
    grunt.initConfig({

        drupalRoot: '../../../',
        appFolder: 'app/',
        distFolder: 'dist/',

        clean: ['<%= appFolder %>css/', '<%= appFolder %>js/', '<%= distFolder %>'],

        concurrent: {
            development: ['sass:development', 'coffee']
        },

        csslint: {
            options: {
                csslintrc: '<%= drupalRoot %>.csslintrc'
            },
            strict: {
                src: ['<%= appFolder %>css/**/*.css']
            }
        },

        coffeelint: {
            app: '<%= appFolder %>coffee/*.coffee'
        },

        sass: {
            development: {
                options: {
                    style: 'expanded',
                    lineNumber: true
                },
                files: [{
                    expand: true,
                    cwd: '<%= appFolder %>sass/',
                    src: '*.scss',
                    dest: '<%= appFolder %>css/',
                    ext: '.css'
                }]
            },
            production: {
                options: {
                    style: 'compressed',
                    lineNumbers: false
                },
                files: [{
                    expand: true,
                    cwd: '<%= appFolder %>sass/',
                    src: '*.scss',
                    dest: '<%= appFolder %>css/',
                    ext: '.css'
                }]
            }
        },

        coffee: {
            compileWithMaps: {
                options: {
                    sourceMap: true
                },
                files: {
                    '<%= appFolder %>js/main.js': '<%= appFolder %>coffee/*.coffee'
                }
            }
        },

        rtlcss: {
            development: {
                files: {
                    '<%= appFolder %>css/style-rtl.css': '<%= appFolder %>css/style.css',
                    '<%= appFolder %>css/horizontal-menu-rtl.css': '<%= appFolder %>css/horizontal-menu.css',
                }
            }
        },

        browserSync: {
            dev: {
                bsFiles: {
                    src: ['<%= appFolder %>css/**/*.css', 'templates/**/*.twig' /*, '<%= appFolder %>js/!**!/!*.js'*/]
                },
                options: {
                    open: false,
                    watchTask: true,
                    proxy: "localhost",
                    ui: {
                        port: 8081
                    }
                }
            }
        },

        prompt: {
            target: {
                options: {
                    questions: [
                        {
                            config: 'cacheRebuild',
                            type: 'confirm',
                            message: 'Rebuild drupal cache?',
                            default: false,
                        }
                    ],
                    then: function (v) {
                        if (v.cacheRebuild) {
                            grunt.task.run('rebuildDrupalCache');
                        }
                        return false;
                    }
                }
            }
        },

        watch: {
            css: {
                files: ['<%= appFolder %>sass/**/*.scss'],
                tasks: ['sass:development', /*'csslint',*/ 'rtlcss:development']
            },
            coffee: {
                files: ['<%= appFolder %>coffee/**/*.coffee'],
                tasks: ['coffee', 'coffeelint']
            }/*,
            twig: {
                files: ['**!/!*.twig'],
                tasks: ['prompt:target']
            }*/
        },

        concat: {
            css: {
                src: ['<%= appFolder %>css/style.css', '<%= appFolder %>css/payam.css'],
                dest: '<%= distFolder %>style.min.css'
            }
        },

        uglify: {
            options: {
                compress: {
                    drop_console: true
                },
                mangle: true
            },
            target: {
                files: {
                    '<%= distFolder %>output.min.js': ['<%= appFolder %>js/main.js']
                }
            }
        },

        shell: {
            multiple: {
                command: [
                    'drupal cache:rebuild all'
                ].join('&&')
            }
        }

    });

    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-prompt');
    grunt.loadNpmTasks('grunt-shell');
    grunt.loadNpmTasks('grunt-concurrent');
    grunt.loadNpmTasks('grunt-contrib-csslint');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-browser-sync');
    grunt.loadNpmTasks('grunt-rtlcss');

    grunt.registerTask('rebuildDrupalCache', ['shell']);
    grunt.registerTask('default', ['clean', 'sass', 'csslint']);
    grunt.registerTask('server', ['clean', 'concurrent:development', 'browserSync', 'watch']);
    grunt.registerTask('build', ['clean', 'sass:production', 'csslint', 'coffee', 'coffeelint', 'concat', 'uglify']);
};
