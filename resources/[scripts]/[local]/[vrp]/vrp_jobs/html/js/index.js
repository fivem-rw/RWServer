$(function() {
  $(document).keyup(function(e) {
      if (e.keyCode == 27) {
          $(".container-fluid").fadeOut();
          $.post('http://vrp_jobs/fechar', JSON.stringify({}));
      }
  });
  $(document).ready(function() {
      window.addEventListener('message', function(event) {
          var item = event.data;
          if (item.ativa == true) {
              $('.container-fluid').css('display', 'block');
          } else if (item.ativa == false) {
              $('.container-fluid').css('display', 'none');
          }
      });

      $("#1").click(function() {
          $.post('http://vrp_jobs/1', JSON.stringify({}));
          2

      });

      $("#2").click(function() {
          $.post('http://vrp_jobs/2', JSON.stringify({}));
          2

      });

      $("#3").click(function() {
          $.post('http://vrp_jobs/3', JSON.stringify({}));
          2

      });

      $("#4").click(function() {
          $.post('http://vrp_jobs/4', JSON.stringify({}));
          2

      });

      $("#5").click(function() {
        $.post('http://vrp_jobs/5', JSON.stringify({}));
        2

    });
    $("#6").click(function() {
        $.post('http://vrp_jobs/6', JSON.stringify({}));
        2

    });
    $("#7").click(function() {
        $.post('http://vrp_jobs/7', JSON.stringify({}));
        2

    });
    $("#8").click(function() {
        $.post('http://vrp_jobs/8', JSON.stringify({}));
        2

    });

    $("#9").click(function() {
        $.post('http://vrp_jobs/9', JSON.stringify({}));
        2

    });
    $("#10").click(function() {
        $.post('http://vrp_jobs/10', JSON.stringify({}));
        2

    });

})
})



let scale = 0;
const cards = Array.from(document.getElementsByClassName("job"));
const inner = document.querySelector(".inner");

function slideAndScale() {
  cards.map((card, i) => {
      card.setAttribute("data-scale", i + scale);
      inner.style.transform = "translateX(" + scale * 8.5 + "em)";
  });
}

(function init() {
  slideAndScale();
  cards.map((card, i) => {
      card.addEventListener("click", () => {
          const id = card.getAttribute("data-scale");
          if (id !== 2) {
              scale -= id - 2;
              slideAndScale();
          }
      }, false);
  });
})();
