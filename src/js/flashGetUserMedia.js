/**
 * @author Maciej Zasada maciejzsd@gmail.com
 * @copyright Maciej Zasada
 * Date: 6/24/13
 * Time: 2:56 PM
 */

(function (window, document, navigator) {

    'use strict';
    var flashGetUserMediaObject, flashGetUserMedia, flashAudioContext, MediaStreamSource, JavaScriptNode, Utils;

    Utils = {

        id: 'flashGetUserMedia',
        flash: null,
        delayedCalls: [],
        successHandler: null,
        failureHandler: null,
        lastOptions: null,
        mediaStreamSource: null,

        options: {

            swfPath: 'flashGetUserMedia.swf'

        },

        loadFlash: function (url) {

            // var container = document.createElement('div'),
            var container = document.getElementById('flashGetUserMedia'),
                flashvars = {
                    initHandler: 'flashGetUserMedia.pluginReady'
                },
                params = {
                    // menu: 'false',
                    allowScriptAccess: 'always',
                    wmode: 'direct'
                },
                attributes = {};

            container.id = Utils.id;
            // document.body.appendChild(container);
            swfobject.embedSWF(url, Utils.id, '600', '600', '11.1.0', 'expressInstall.swf', flashvars, params, attributes);

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

    /**
     * JavaScriptNode
     * @constructor
     */
    JavaScriptNode = function (bufferLength, numInputs, numOutputs) {

        this.bufferLength = bufferLength;
        this.numInputs = numInputs;
        this.numOutputs = numOutputs;
        this.onaudioprocess = null;

    };

    JavaScriptNode.prototype = {

        connect: function (destination) {
        }

    };

    /**
     * MediaStreamSource
     * @constructor
     */
    MediaStreamSource = function (context, source) {

        this.context = context;
        this.source = source;
        this.node = null;

        Utils.mediaStreamSource = this;

    };

    MediaStreamSource.prototype = {

        connect: function (node) {

            this.node = node;

        }

    };

    /**
     * flashAudioContext
     * @constructor
     */
    flashAudioContext = function () {

        this.sampleRate = -1;

    };

    flashAudioContext.prototype = {

        createMediaStreamSource: function (mediaStreamSource) {

            this.sampleRate = mediaStreamSource.microphone ? mediaStreamSource.microphone.rate * 1000 : -1;
            return new MediaStreamSource(this, mediaStreamSource);

        },

        createJavaScriptNode: function (bufferLength, numInputs, numOutputs) {

            Utils.flash.setBufferLength(bufferLength);
            return new JavaScriptNode(bufferLength, numInputs, numOutputs);

        }

    };

    /**
     * flashGetUserMedia
     * @param options
     * @param successHandler
     * @param failureHandler
     */
    flashGetUserMedia = function (options, successHandler, failureHandler) {

        if (flashGetUserMediaObject.ready) {

            Utils.successHandler = successHandler;
            Utils.failureHandler = failureHandler;
            Utils.lastOptions = options;
            Utils.flash.getUserMedia(options);

        } else {

            Utils.delayCall(this, flashGetUserMedia, arguments);

        }

    };

    /**
     * flashGetUserMediaObject
     */
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
                window.AudioContext = flashAudioContext;

            }

            if (navigator.getUserMedia === flashGetUserMedia) {

                Utils.loadFlash(Utils.options.swfPath);

            }

        },

        stopRecording: function () {

            Utils.flash.stopRecording();

        },

        pluginReady: function () {

            Utils.flash = document.getElementById(Utils.id);
            flashGetUserMediaObject.ready = true;
            Utils.executeDelayedCalls();

        },

        maximize: function () {

            // Utils.flash.width = 215;
            // Utils.flash.height = 138;

        },

        minimize: function () {

            // Utils.flash.width = 1;
            // Utils.flash.height = 1;

        },

        onMediaStatus: function (camera, microphone, stream) {

            if ((!Utils.lastOptions.audio || microphone) && (!Utils.lastOptions.video || camera)) {

                if (typeof Utils.successHandler === 'function') {

                    Utils.successHandler(stream);

                }

            } else {

                if (typeof Utils.failureHandler === 'function') {

                    Utils.failureHandler();

                }

            }

        },

        onMicrophoneSample: function (leftChannel, rightChannel) {

            if (Utils.mediaStreamSource && Utils.mediaStreamSource.node && typeof Utils.mediaStreamSource.node.onaudioprocess === 'function') {

                Utils.mediaStreamSource.node.onaudioprocess({inputBuffer: {

                    getChannelData: function (channel) {

                        return channel === 0 ? leftChannel : rightChannel;

                    }

                }});

            }

        }

    };

    navigator.flashGetUserMedia = flashGetUserMedia;
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || navigator.flashGetUserMedia;
    window.AudioContext = window.AudioContext || window.webkitAudioContext || flashAudioContext;

    window.flashGetUserMedia = flashGetUserMediaObject;

}(window, document, navigator));
