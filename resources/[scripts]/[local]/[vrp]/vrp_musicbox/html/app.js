// ---------------------------------------------------------
// ------------ VRP Musicbox, RealWorld MAC ----------------
// -------------- https://discord.gg/realw -----------------
// ---------------------------------------------------------

var players = {}

function newPlayer(id, ready) {
    $('#PlayerList').append('<div style="visibility:hidden" id="player' + id + '"></div>')
    players[id] = new YT.Player('player' + id, {
        width: '1',
        height: '1',
        playerVars: {
            'autoplay': 0,
            'controls': 0,
            'disablekb': 1,
            'enablejsapi': 1,
        },
        events: {
            'onReady': function (event) {
                title = event.target.getVideoData().title;
                players[id].setVolume(30);
                players[id].sendPlayTimeTimer = setInterval(function () {
                    $.post('http://vrp_musicbox/setPlayTime', JSON.stringify({ id: id, currentTime: parseInt(players[id].getCurrentTime()) }))
                }, 1000)
                if (typeof ready == "function") {
                    ready()
                }
            },
            'onStateChange': function (event) {
                if (event.data == YT.PlayerState.PLAYING) {
                    title = event.target.getVideoData().title;
                }
                if (event.data == YT.PlayerState.ENDED) {
                }
                $.post('http://vrp_musicbox/state', JSON.stringify({ id: id, data: event.data }))
            },
            'onError': function (event) {
                switch (event.data) {
                    case 2:
                        $.post('http://vrp_musicbox/error', JSON.stringify({ id: id, code: event.data }))
                        console.log("The video id: " + id + " seems invalid, wrong video id?");
                        break;
                    case 5:
                        $.post('http://vrp_musicbox/error', JSON.stringify({ id: id, code: event.data }))
                        console.log("An HTML 5 player issue occured on video id: " + id);
                    case 100:
                        $.post('http://vrp_musicbox/error', JSON.stringify({ id: id, code: event.data }))
                        console.log("Video " + id + "does not exist, wrong video id?");
                    case 101:
                    case 150:
                        $.post('http://vrp_musicbox/error', JSON.stringify({ id: id, code: event.data }))
                        console.log("Embedding for video id " + id + " was not allowed.");
                        console.log("Please consider removing this video from the playlist.");
                        break;
                    default:
                        $.post('http://vrp_musicbox/error', JSON.stringify({ id: id, code: 999 }))
                        console.log("An unknown error occured when playing: " + id);
                }
            }
        }
    });
}

function delPlayer(id) {
    if (id && players[id] && players[id].sendPlayTimeTimer) {
        clearInterval(players[id].sendPlayTimeTimer)
        $('#player' + id).remove();
        players[id] = null
    }
}

function resume(id) {
    if (players[id]) {
        players[id].playVideo();
    }
}

function pause(id) {
    if (players[id]) {
        players[id].pauseVideo();
    }
}

function stop(id) {
    if (players[id]) {
        players[id].stopVideo();
    }
}

function setVolume(id, volume) {
    if (players[id]) {
        players[id].setVolume(volume)
    }
}

window.addEventListener('message', function (event) {
    var _data = event.data
    if (_data.type == "newBox") {
        newPlayer(_data.playerId);
    }
    if (_data.type == "delBox") {
        delPlayer(_data.playerId);
    }
    if (_data.type == "playSound") {
        play(_data.playerId, _data.videoId, _data.startTime);
    }
    if (_data.type == "stopSound") {
        stop(_data.playerId);
    }
    if (_data.type == "volume") {
        setVolume(_data.playerId, _data.volume);
    }
})

var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";

var ytScript = document.getElementsByTagName('script')[0];
ytScript.parentNode.insertBefore(tag, ytScript);

function onYouTubeIframeAPIReady() {
    console.log('onYouTubeIframeAPIReady')
}

function play(id, videoId, startTime) {
    if (!videoId) {
        return false
    }
    if (players[id]) {
        players[id].loadVideoById({
            'videoId': videoId,
            'startSeconds': startTime,
            'endSeconds': 3600,
            'suggestedQuality': 'tiny'
        });
        players[id].playVideo();
    } else {
        newPlayer(id, function () {
            players[id].loadVideoById({
                'videoId': videoId,
                'startSeconds': startTime,
                'endSeconds': 3600,
                'suggestedQuality': 'tiny'
            });
            players[id].playVideo();
        });
    }
}