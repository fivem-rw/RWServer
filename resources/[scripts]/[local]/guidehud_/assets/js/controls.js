 $(function () {
    $.post('http://guidehud/closeGuideHud', JSON.stringify({}));

     $(document).keyup(function (e) {
         if (e.keyCode == 27) {
             $('.jumbotron').stop().fadeOut();
             $.post('http://guidehud/closeGuideHud', JSON.stringify({}));
         }
     });

     window.addEventListener('message', function (event) {
         if (event.data.type == "openGuideHud") {
             $('.jumbotron').stop().fadeIn();
             $.post('http://guidehud/openGuideHud', JSON.stringify({}));
         }
         if (event.data.type == "closeGuideHud") {
             $('.jumbotron').stop().fadeOut();
         }
     });

     $("#exit_gui").click(() => {
         $('.jumbotron').stop().fadeOut();
         $.post('http://guidehud/closeGuideHud', JSON.stringify({}));
     });
 });
