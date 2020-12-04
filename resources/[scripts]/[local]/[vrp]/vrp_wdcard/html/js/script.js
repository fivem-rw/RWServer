$(document).ready(function () {
  $(document).keyup(function (e) {
    let keyCode = e.keyCode || e.which;
    if (keyCode == 113 || keyCode == 27) {
      $.post('http://vrp_wdcard/hide')

      $('body').hide()
      $('.wdcard-button').hide()

      $('.wdcard-container').hide()
      $('canvas').fadeOut(2500);
      var v = document.getElementsByTagName("audio")[0];
      v.pause();

    }
    if (keyCode == 69) {
      $.post('http://vrp_wdcard/setPoint')
    }
  });
  $('#cardbutton').on('click', function () {
    $('.wdcard-button').hide()
    $('.wdcard-container').show()

    var v = document.getElementsByTagName("audio")[0];
    v.volume = .8;
    v.loop = true;
    var play = true;
    v.play();

    $('canvas').hide().fadeIn(2500);
    $('#greeting_text').hide().delay(1000).fadeIn(2000).css({ visibility: 'visible' });
    $('#owner_name').hide().delay(1500).fadeIn(2000).css({ visibility: 'visible' });
    $('#desc').hide().delay(1500).fadeIn(2000).css({ visibility: 'visible' });
    $('#desc2').hide().delay(1500).fadeIn(2000).css({ visibility: 'visible' });

    $("#bt_sound").hide().delay(2500).fadeIn(1000).css({ opacity: 0.3, visibility: 'visible' }).click(function () {
      if (play) {
        v.pause();
        $('#bt_sound').attr({ src: "icon/bt_disable.png" });
      } else {
        v.play();
        $('#bt_sound').attr({ src: "icon/bt_enable.png" });
      }
      play = !play;
    }).hover(
      function () { $(this).stop().animate({ opacity: 1.0 }, 100); },
      function () { $(this).stop().animate({ opacity: 0.3 }, 500); }
    );
  })
  $('#cardbutton').on('mouseover', function () {
    $('#cardbutton').css({ 'transform': 'scale(1.2)' })
  })
  $('#cardbutton').on('mouseout', function () {
    $('#cardbutton').css({ 'transform': 'scale(1)' })
  })
})
window.addEventListener('message', function (event) {
  switch (event.data.action) {
    case 'open':
      $('body').show()
      $('.wdcard-button').show()


      break;
    case 'close':
      $.post('http://vrp_wdcard/hide')

      $('body').hide()
      $('.wdcard-button').hide()

      $('.wdcard-container').hide()
      $('canvas').fadeOut(2500);
      var v = document.getElementsByTagName("audio")[0];
      v.pause();
      break;
    case 'openc':


      break;
    case 'closec':
      break;
  }
})