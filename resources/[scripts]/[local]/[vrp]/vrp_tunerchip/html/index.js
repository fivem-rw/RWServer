function AlterarValoresC(values) {
	$(".slider").each(function(){
		if(values[this.id]!=null) {
			$(this).slider("value",values[this.id]);
		}
	});
	UpdateviaJs();
}

function ChecarValoresS() {
	return {boost:$("#boost").slider("value"),fuelmix:$("#fuelmix").slider("value"),gearchange:$("#gearchange").slider("value"),braking:$("#braking").slider("value"),drivebiass:$("#drivebiass").slider("value"),brakeforce:$("#brakeforce").slider("value")};
}

function UpdateviaJs(event,ui) {
}

function AlterarSMenu(bool,send=false) {
	if(bool) {
		$("body").show();
	} else {
		$("body").hide();
	}
	if(send){
		$.post('http://vrp_tunerchip/AcaonoMenu', JSON.stringify({state:false}));
	}
}

$(function(){
	$("body").hide();
	$("#boost").slider({min:0.1,value:0.25,step:0.01,max:0.75,change:UpdateviaJs});
	$("#fuelmix").slider({min:1,value:1.3,step:0.01,max:2,change:UpdateviaJs});
	$("#gearchange").slider({min:1,value:9,max:50,change:UpdateviaJs});
	$("#braking").slider({value:0.5,max:1,step:0.05,change:UpdateviaJs});
	$("#drivebiass").slider({value:0.5,max:1,step:0.05,change:UpdateviaJs});
	$("#brakeforce").slider({value:1.4,max:2,step:0.05,change:UpdateviaJs});
	$("#defaultbtn").click(function(){AlterarValoresC({boost:0.25,fuelmix:1.3,gearchange:9,braking:0.5,drivebiass:0.5,brakeforce:1.4});});
	$("#sportbtn").click(function(){AlterarValoresC({boost:0.5,fuelmix:1.5,gearchange:10,braking:0.4,drivebiass:0.6,brakeforce:1.5});});
	$("#savebtn").click(function(){
		$.post('http://vrp_tunerchip/SalvarVeh', JSON.stringify(ChecarValoresS()));
	});
	$("#DarkMode").click(function(){
		$(this).toggleClass("fa");
		$(this).toggleClass("far");
		$(".monitor").toggleClass("monitor-claro");
		$(".monitor").toggleClass("monitor-escuro");
	});
	$("#soundmade").click(function(){
		$(this).toggleClass("fa fa-volume-up");
		$(this).toggleClass("fa fa-volume-off");
	});
	$("#exitProgram").click(function(){
		AlterarSMenu(false,true);
	});
	setInterval(() => {
		var DiaAtual = new Date();
		var Dias = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"];
		var DiasMostrar = DiaAtual.getDay()
		var HorasMostrar = DiaAtual.getHours()
		var SegundosMostrar = DiaAtual.getMinutes().toString().length==1 ? "0"+DiaAtual.getMinutes() : DiaAtual.getMinutes()
		var Tempo = Dias[DiasMostrar] + " - " + HorasMostrar + ":" + SegundosMostrar;
		$("#TempoSuperior").text(Tempo);
	}, 1000);
	window.addEventListener('message', function(event){
		if(event.data.type=="AcaonoMenu") {
			AlterarSMenu(event.data.state,false);
			if(event.data.data!=null) {
				AlterarValoresC(event.data.data);
			}
		}
	});
	document.onkeyup = function (data) {
        if (data.which == 27) {
            AlterarSMenu(false,true);
        }
    };
});