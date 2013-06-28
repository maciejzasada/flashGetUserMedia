flashGetUserMedia
=================

Provides WebRTC getUserMedia() fallback via Flash plugin for browsers that do not support getUserMedia() natively.

### Usage ###

```javascript
flashGetUserMedia.init({swfPath: 'flashGetUserMedia.swf', force: false});
navigator.getUserMedia({audio: true, video: false}, successHandler, failureHandler);
```

### Options ###

* `swfPath` path to flashGetUserMedia.swf file
* `force` force usage of flashGetUserMedia even if native getUserMedia is supported by the browser 

### Example implementation ###

```html
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="vendor/recorder.js"></script>
    <script type="text/javascript" src="flashGetUserMedia.js"></script>
</head>
<body>

<script>

    var audioContext, mediaStreamSource, recorder;

    function onGetMediaSuccess(source) {

        mediaStreamSource = audioContext.createMediaStreamSource(source);
        setTimeout(function () {
            record();
        }, 1);

    }

    function onGetMediaFail() {

        console.log('media fail handler');

    }

    function record() {

        recorder = new Recorder(mediaStreamSource);
        recorder.record();

    }

    function stopAndPlay() {

        recorder.stop();
        recorder.exportWAV(function(s) {

            var audio = document.createElement( 'audio' );
            audio.src = window.URL.createObjectURL(s);
            audio.id = 'record';
            document.body.appendChild(audio);
            audio.play();

        });

    }

    flashGetUserMedia.init({swfPath: 'flashGetUserMedia.swf', force: true});

    audioContext = new AudioContext();
    navigator.getUserMedia({audio: true, video: false}, onGetMediaSuccess, onGetMediaFail);

</script>

</body>
</html>
```

### Project Status ###

v. 0.1 (28/06/2013)
* experimental implementation
* Microphone implemented
* allow / deny handling
* possible to access microphone data via JS with idential interface to HTML5
* possible to record and play back microphone data via JS with identical interface to HTML5
* Camera implementation pending
