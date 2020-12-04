//---------------------------------------------------------
//-------------- RealWorld MAC - VRP UserList -------------
//-------------- https://discord.gg/realw -----------------
//---------------------------------------------------------

let toggleKeyCode = 0
let visable = false;
let selectType = "all"
let playerList = {}

function printPlayerList(type) {
	$('#playerlist').empty();
	let html = ''
	let playerList2 = []
	if (type == "all") {
		playerList2 = playerList
	} else {
		$.each(playerList, function (i, v) {
			if (v.jobType && v.jobType == type) {
				playerList2.push(v)
			}
			if (v.jobType != type && v.jobType2 == type) {
				playerList2.push(v)
			}
		})
	}

	$.each(playerList2, function (i, v) {
		if (i % 3 == 0) {
			html += '<tr>'
		}
		html += `<td data-type="${v.jobType}"><span>${v.id}</span></td><td data-type="${v.jobType}">${v.nickname}</td><td data-type="${v.jobType}">${v.job}</td>`;
		if ((i + 1) % 3 == 0) {
			html += '</tr>'
		}
	})

	let addCount = 3 - (playerList2.length % 3)
	if (addCount != 3) {
		for (let i = 0; i < addCount; i++) {
			html += `<td class="empty">&nbsp;</td><td class="empty">&nbsp;</td><td class="empty">&nbsp;</td>`;
		}
	}

	$('#playerlist').html(html)
}

function sortPlayerList() {
	let table = $('#playerlist')
	let rows = $('tr:not(.heading)', table);

	rows.sort(function (a, b) {
		let keyA = $('td', a).eq(1).html();
		let keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function (index, row) {
		table.append(row);
	});
}

$(function () {
	$(document).keyup(function (e) {
		let keyCode = e.keyCode || e.which;
		if (keyCode == toggleKeyCode || keyCode == 27) {
			$('#wrap').fadeOut().hide()
			$.post('http://vrp_rw_userlist/hideList')
			visable = !visable;
		}
	});
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'init':
				toggleKeyCode = event.data.toggleKey;
				let categories = event.data.categories;
				$.each(categories, function (i, v) {
					$('#tabType').append(`<p data-type="${v[1]}" class="">${v[3]} ${v[2]}: <span id="${v[1]}">0</span> </p>`)
				})
				$('#tabType p[data-type="all"]').addClass('active')

				$('.jobs p').on('click', function (e) {
					$('.jobs p').removeClass('active')
					$(e.currentTarget).addClass('active')
					let type = $(e.currentTarget).attr('data-type')
					selectType = type
					printPlayerList(selectType)
					return false;
				})
				break;
			case 'toggle':

				if (visable) {
					$('#wrap').fadeOut();
					$.post('http://vrp_rw_userlist/hideList')
				} else {
					$('#wrap').fadeIn();
					$.post('http://vrp_rw_userlist/showList')
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').fadeOut();
				visable = false;
				break;

			case 'updatePlayerJobs':
				let jobs = event.data.jobs;
				$('#player_count').html(jobs.all);
				$('#all').html(jobs.all);
				$('#subae').html(jobs.subae);
				$('#ems').html(jobs.ems);
				$('#cop').html(jobs.cop);
				$('#uber').html(jobs.uber);
				$('#repair').html(jobs.repair);
				$('#shh').html(jobs.shh);
				$('#mafia').html(jobs.mafia);
				$('#gm').html(jobs.gm);
				$('#tow').html(jobs.tow);
				$('#cbs').html(jobs.cbs);
				$('#dok').html(jobs.dok);
				$('#kys').html(jobs.kys);
				$('#helper').html(jobs.helper);
				$('#inspector').html(jobs.inspector);
				$('#admin').html(jobs.admin);
				break;

			case 'updatePlayerList':
				playerList = event.data.players
				printPlayerList(selectType)
				$('#max_players').text(event.data.maxClients);
				break;

			case 'updateServerInfo':
				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}
				break;

			default:
				break;
		}
	}, false);

	$('.btn-close').on('click', function (e) {
		$('#wrap').fadeOut().hide()
		$.post('http://vrp_rw_userlist/hideList')
		visable = !visable;
		return false;
	})
});