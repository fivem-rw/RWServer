$(document).ready(function () {
    window.addEventListener('message', function (event) {
        var data = event.data;


        $("#energyfull").css("opacity", data.stamina / 100);
        $("#energyfull").hide()
        $('#energyout').hide()

        $('.healthnumber2').text(data.armor);
        if (data.stamina <= 15) {
            $("#triedx").show();

        } else if (data.stamina >= 15) {
            $("#triedx").hide();

        }
        if (data.getvehicle == true) {
            $(".crackgrass").show();

            if (data.carhealth <= 900 && data.carhealth >= 801) {

                $("#crack1").show();
                $("#crack2").hide();
                $("#crack3").hide();
                $("#crack4").hide();
                $("#crack5").hide();
                $("#crack6").hide();
                $("#crack7").hide();
                $("#crack8").hide();

            } else if (data.carhealth <= 800 && data.carhealth >= 701) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").hide();
                $("#crack4").hide();
                $("#crack5").hide();
                $("#crack6").hide();
                $("#crack7").hide();
                $("#crack8").hide();

            } else if (data.carhealth <= 700 && data.carhealth >= 601) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").show();
                $("#crack4").hide();
                $("#crack5").hide();
                $("#crack6").hide();
                $("#crack7").hide();
                $("#crack8").hide();

            } else if (data.carhealth <= 600 && data.carhealth >= 501) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").show();
                $("#crack4").show();
                $("#crack5").hide();
                $("#crack6").hide();
                $("#crack7").hide();
                $("#crack8").hide();

            } else if (data.carhealth <= 500 && data.carhealth >= 401) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").show();
                $("#crack4").show();
                $("#crack5").show();
                $("#crack6").hide();
                $("#crack7").hide();
                $("#crack8").hide();

            } else if (data.carhealth <= 400 && data.carhealth >= 301) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").show();
                $("#crack4").show();
                $("#crack5").show();
                $("#crack6").show();
                $("#crack7").hide();
                $("#crack8").hide();

            } else if (data.carhealth <= 300 && data.carhealth >= 201) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").show();
                $("#crack4").show();
                $("#crack5").show();
                $("#crack6").show();
                $("#crack7").show();
                $("#crack8").hide();

            } else if (data.carhealth <= 200 && data.carhealth >= 100) {
                $("#crack1").show();
                $("#crack2").show();
                $("#crack3").show();
                $("#crack4").show();
                $("#crack5").show();
                $("#crack6").show();
                $("#crack7").show();
                $("#crack8").show();

            } else if (data.carhealth == 1000) {
                $("#crack1").hide();
                $("#crack2").hide();
                $("#crack3").hide();
                $("#crack4").hide();
                $("#crack5").hide();
                $("#crack6").hide();
                $("#crack7").hide();
                $("#crack8").hide();

            }

        } else if (data.getvehicle == false) {

            $(".crackgrass").hide();
        }


        if (data.armor == 0) {
            $('#vest45').hide();
            $('#vest20').hide();
            $('#vest100').hide();

        } else if (data.armor >= 46) {
            $('#vest45').hide();
            $('#vest20').hide();
            $('#vest100').show();
        }
        else if (data.armor <= 45 && data.armor > 20) {
            $('#vest45').show();
            $('#vest20').hide();
            $('#vest100').hide();
        }
        else if (data.armor <= 20) {
            $('#vest45').hide();
            $('#vest20').show();
            $('#vest100').hide();
        }
        if (data.health > 45) {


            $('#blood45').hide();
            $('#blood20').hide();
            $('#bloodscreen').hide();
        } else if (data.health <= 45 && data.health > 20) {
            $('#blood45').show();
            $('#blood20').hide();
            $('#bloodscreen').hide();
        } else if (data.health <= 20) {
            $('#blood45').hide();
            $('#blood20').show();
            $('#bloodscreen').show();
        }
        if (data.show == true) {
            $(".container").hide();
        } else if (data.show == false) {
            $(".container").show();
        }


    })
})