/**
 * @author Maciej Zasada maciejzsd@gmail.com
 * @copyright Maciej Zasada
 * Date: 6/24/13
 * Time: 2:56 PM
 */

(function (window, document, navigator) {

    'use strict';
    var flashGetUserMediaObject, flashGetUserMedia, flashAudioContext, Utils;

    Utils = {

        id: 'flashGetUserMedia',
        flash: null,
        delayedCalls: [],
        successHandler: null,
        failureHandler: null,
        lastOptions: null,

        options: {

            swfPath: 'flashGetUserMedia.swf'

        },

        loadFlash: function (url) {

            console.log('loading Flash from', url);

            var container = document.createElement('div'),
                flashvars = {
                    initHandler: 'flashGetUserMedia.pluginReady'
                },
                params = {
                    menu: 'false',
                    allowScriptAccess: 'always'
                },
                attributes = {};

            container.id = Utils.id;
            document.body.appendChild(container);
            swfobject.embedSWF(url, Utils.id, '0', '0', '11.1.0', 'expressInstall.swf', flashvars, params, attributes);

        },

        delayCall: function (target, f, args) {

            Utils.delayedCalls.push({target: target, f: f, args: args});

        },

        executeDelayedCalls: function () {

            var i;

            for (i = 0; i < Utils.delayedCalls.length; ++i) {

                Utils.delayedCalls[i].f.apply(Utils.delayedCalls[i].target, Utils.delayedCalls[i].args);

            }

            Utils.delayedCalls = [];

        }

    };

    flashGetUserMedia = function (options, successHandler, failureHandler) {

        if (flashGetUserMediaObject.ready) {

            console.log('executing getUserMedia', options);
            Utils.successHandler = successHandler;
            Utils.failureHandler = failureHandler;
            Utils.lastOptions = options;
            Utils.flash.getUserMedia(options);

        } else {

            Utils.delayCall(this, flashGetUserMedia, arguments);

        }

    };

    flashAudioContext = function () {

        console.log('audio context');

    };

    flashGetUserMediaObject = {

        ready: false,

        init: function (options) {

            var field;

            for (field in options) {

                if (typeof options[field] !== 'function') {

                    Utils.options[field] = options[field];

                }

            }

            if (Utils.options.force) {

                navigator.getUserMedia = flashGetUserMedia;

            }

            if (navigator.getUserMedia === flashGetUserMedia) {

                Utils.loadFlash(Utils.options.swfPath);

            }

        },

        pluginReady: function () {

            Utils.flash = document.getElementById(Utils.id);
            flashGetUserMediaObject.ready = true;
            Utils.executeDelayedCalls();

        },

        maximize: function () {

            Utils.flash.width = 215;
            Utils.flash.height = 137;

        },

        minimize: function () {

            Utils.flash.width = 0;
            Utils.flash.height = 0;

        },

        onMediaStatus: function (camera, microphone, stream) {

            console.log('media status', camera, microphone);

            if ((!Utils.lastOptions.audio || microphone) && (!Utils.lastOptions.video || camera)) {

                if (typeof Utils.successHandler === 'function') {

                    Utils.successHandler(stream);

                }

            } else {

                if (typeof Utils.failureHandler === 'function') {

                    Utils.failureHandler();

                }

            }

        }

    };

    navigator.flashGetUserMedia = flashGetUserMedia;
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || navigator.flashGetUserMedia;

    window.flashGetUserMedia = flashGetUserMediaObject;

}(window, document, navigator));
