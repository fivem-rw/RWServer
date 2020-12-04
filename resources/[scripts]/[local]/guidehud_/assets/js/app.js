document.addEventListener('DOMContentLoaded', function () {
  document.querySelector('.navbar-brand').innerHTML = config.title;
  document.querySelector('#pills-home h1').innerHTML = config.welcomeMessage;
  document.querySelector('#pills-home h2 kbd').innerHTML = config.menuHotkey;

  announcementItem();
  ruleItems();
  hotkeyItems();
});

function loadingScreen() {
  slider();
  cursor();
  community();
}

function slider() {
  var background = document.getElementById('background');

  config.images.forEach(function (image) {
    var img = document.createElement('img');

    img.src = image;
    background.appendChild(img);
  });

  var current = 0;
  var slides = background.childNodes;

  setInterval(function() {
    for (var i = 0; i < slides.length; i++) {
      slides[i].style.opacity = 0;
    }
    current = (current != slides.length - 1) ? current + 1 : 0;
    slides[current].style.opacity = 1;
  }, 5000);
}

function announcementItem() {
  var announcementList = document.querySelector('#pills-home ul');

  announcements.forEach(function (announcement) {
    var li = document.createElement('li');

    li.innerHTML = announcement;
    announcementList.appendChild(li);
  });
}

function community() {
  if (config.discord.show == true) {
    document.querySelector('.discord p').innerHTML = config.discord.discordLink;
  } else {
    document.querySelector('.discord').style.display = 'none';
  }
}

function ruleItems() {
  var guidelineList = document.querySelector('#v-pills-guidelines');
  var generalconductList = document.querySelector('#v-pills-general-conduct');
  var roleplayingList = document.querySelector('#v-pills-rprules');
  var rdmvdmList = document.querySelector('#v-pills-rdmvdm');
  var metagamingList = document.querySelector('#v-pills-meta-powergaming');
  var newlifeList = document.querySelector('#v-pills-newlife');
  var abuseList = document.querySelector('#v-pills-exploits');

}

function hotkeyItems() {
  var generalhotkeyList = document.querySelector('#v-pills-general');
  var rphotkeyList = document.querySelector('#v-pills-rp');
  var vehiclehotkeyList = document.querySelector('#v-pills-vehicles');
  var jobshotkeyList = document.querySelector('#v-pills-jobs');

  generalhotkeys.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    generalhotkeyList.appendChild(p);
  });

  rphotkeys.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    rphotkeyList.appendChild(p);
  });

  vehiclehotkeys.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    vehiclehotkeyList.appendChild(p);
  });

  jobshotkeys.forEach(function (item) {
    var p = document.createElement('p');

    p.innerHTML = item;
    jobshotkeyList.appendChild(p);
  });
}

function cursor() {
  document.body.addEventListener("mousemove", function (event) {
    var x = event.pageX - 6 + "px"
    var y = event.pageY + "px"
    document.getElementById("cursor").style.left = x;
    document.getElementById("cursor").style.top = y;
  })
};