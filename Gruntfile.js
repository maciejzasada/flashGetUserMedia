/**
 * @author Maciej Zasada maciejzsd@gmail.com
 * @copyright Maciej Zasada
 * Date: 6/24/13
 * Time: 2:56 PM
 */

module.exports = function (grunt) {

    grunt.initConfig({

        jslint: {

            files: [
                'src/js/flashGetUserMedia.js'
            ],

            options: {
                junit: 'log/junit.xml',
                log: 'log/lint.log',
                jslintXml: 'log/jslint_xml.xml',
                errorsOnly: false,
                failOnError: false,
                shebang: true,
                checkstyle: 'log/checkstyle.xml'
            },

            directives: {

                bitwise: true,
                browser: true,
                debug: false,
                devel: true,
                node: false,
                unparam: true,
                plusplus: true,
                todo: true,
                predef: ['swfobject']

            }

        },

        concat: {

            js: {

                src: [
                    'src/js/lib/swfobject.js',
                    'src/js/flashGetUserMedia.js'
                ],

                dest: 'build/flashGetUserMedia.js'

            }

        },

        uglify: {

            main: {
                files: {
                    'build/flashGetUserMedia.min.js': ['build/flashGetUserMedia.js']
                }
            }

        },

        watch: {

            js: {

                files: ['src/js/flashGetUserMedia.js'],
                tasks: ['jslint', 'concat', 'uglify']

            }

        }

    });

    // Grunt plugins.
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-jslint');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['jslint', 'concat', 'uglify']);

};
