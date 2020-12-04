window.addEventListener('message', function (event) {
	var _data = event.data
	if (_data.type == "play") {
		if (_data.message.text) {
			if (!_data.message.name) {
				_data.message.name = "리얼월드"
			}
			const audio = new Audio("https://www.realw.kr/voiceapi/tts?q=" + _data.message.text + "&name=" + _data.message.name);
			audio.play();
		}
	}
})