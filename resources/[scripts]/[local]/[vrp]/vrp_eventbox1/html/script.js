$(function () {
	$(document).keyup(function (e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode == 90 || keyCode == 27) {
			$('#wrap').hide()
			$.post('http://vrp_eventbox1/hideResult')
		}
	});
})

var typeName = {
	"1": "1천원권",
	"2": "5천원권",
	"3": "1만원권",
	"4": "5만원권",
	"5": "10만원권",
	"6": "50만원권"
}

window.addEventListener('message', function (event) {
	var _data = event.data
	if (_data.type == "checkResult") {
		$('.coupon-list').empty()
		if (_data.username) {
			$('#name').text(_data.username)
			$('.username').show()
		}
		if (_data.data == false) {
			$('.coupon-list').append('<li>문화상품권 교환내역이 없습니다.</li>')
		}
		else {
			$.each(_data.data, function (i, v) {
				$('.coupon-list').append('<li>문화상품권 <span class="nName">' + typeName[v[0]] + '</span>: <span class="number">' + v[1] + '</span></li>')
			})
		}
		$('#wrap').show()
	}
})