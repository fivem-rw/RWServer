// ---------------------------------------------------------
// ------------ VRP Musicbox, RealWorld MAC ----------------
// -------------- https://discord.gg/realw -----------------
// ---------------------------------------------------------

const keys = [
    "AIzaSyDr_JiJc8QHIU-g5Jnmd0t_iQuVuOy2hZc",
    "AIzaSyCbtKKsDeQS5NN6UU1x5BQetlqiv6gu5OU",
    "AIzaSyDcZ1JNoBMDkTEFLYFbeSIEDbdH2bw_rR4",
    "AIzaSyDn3CC8X46T5ndrFX1U5Uk9D1SQiXP195A",
    "AIzaSyB1qJSc97EWau3SAEBX1ywtWrfUJT27zE0"
]
let currentKeyIndex = 0
let isLoading = false

$(document).keyup(function (e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode == 27) {
        $youtubeContainer.hide();
        $.post('http://vrp_musicbox/hideYoutubeList')
    }
});

$(document).ready(function () {
    $youtubeContainer = $('#youtue-container')
    $youtubeList = $youtubeContainer.find('.youtube-list')
    $youtubeList.html('<li class="msg">상단의 검색창에 원하는 노래제목을 입력해주세요.</li>')

    window.addEventListener('message', function (event) {
        var _data = event.data
        if (_data.type == "show") {
            $youtubeContainer.show();
            $.post('http://vrp_musicbox/showYoutubeList')
            $('input[name=youtube_search]').prop('disabled', false)
        }
        if (_data.type == "hide") {
            $youtubeContainer.hide();
            $.post('http://vrp_musicbox/hideYoutubeList')
            $('input[name=youtube_search]').prop('disabled', true)
        }
    })
    $('#btn-search-list').on('click', function (e) {
        let value = $('input[name=youtube_search]').val()
        if (value != "") {
            getList(value)
        }
    })
    $('#btn-search-reset').on('click', function (e) {
        $('input[name=youtube_search]').val('')
        $youtubeList.empty()
        $youtubeList.html('<li class="msg">상단의 검색창에 원하는 노래제목을 입력해주세요.</li>')
    })
    $('#btn-close-list').on('click', function (e) {
        $youtubeContainer.hide();
        $.post('http://vrp_musicbox/hideYoutubeList')
    })
    $('#btn-stop').on('click', function (e) {
        $youtubeContainer.hide();
        $.post('http://vrp_musicbox/stopPlay')
        $.post('http://vrp_musicbox/hideYoutubeList')
    })
    $(document).on('click', $youtubeList.find('li'), function (e) {
        let videoId = $(e.target).closest('li').attr('data-id')
        if (videoId && videoId.length > 5) {
            $.post('http://vrp_musicbox/selectVideo', JSON.stringify({ id: videoId }))
        }
    })
    function getList(value) {
        if (isLoading == false) {
            isLoading = true
            $youtubeList.empty()
            $youtubeList.html('<li class="msg">검색중..</li>')
            setTimeout(function () {
                $.ajax({
                    url: `https://www.googleapis.com/youtube/v3/search?part=snippet&q=${value}&maxResults=50&key=` + keys[currentKeyIndex],
                    type: 'GET',
                    dataType: 'json',
                    success: function (res) {
                        $youtubeList.empty()
                        if (res.items && res.items.length > 0) {
                            $.each(res.items, function (i, v) {
                                let html = ''
                                html += `<li class="item" data-id="${v.id.videoId}">`
                                html += '<div class="s-title">' + v.snippet.title + '</div>'
                                html += `<div class="s-thumbnails"><img src="${v.snippet.thumbnails.medium.url}"></div>`
                                html += '</li>'
                                $youtubeList.append(html)
                            })
                        }
                        else {
                            $youtubeList.html('<li class="msg">검색 결과가 없습니다.</li>')
                        }
                    },
                    error: function (e) {
                        if (keys[currentKeyIndex + 1]) {
                            currentKeyIndex++;
                        }
                        else {
                            currentKeyIndex = 0
                        }
                        $youtubeList.html('<li class="msg">요청 오류. 잠시후 다시 시도해주세요.</li>')
                    },
                    complete: function () {
                        isLoading = false
                    }
                })
            }, 500)
        }

    }
})
