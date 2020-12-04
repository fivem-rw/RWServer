var itemName = null;
var itemAmount = null;
var itemIdname = null;
var selectIdName = null;

function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function init(item) {
  if (item.inventory) {
    $("#items").empty();
    item.inventory.forEach(element => {
      var customAction = JSON.stringify(element.customAction)
      $("#items").append('<div onclick="selectItem(this)" data-name="' + element.name + '" data-description="' + element.description + '" data-weight="' + element.weight + '" data-amount="' + element.amount + '" data-datacontent="' + element.dataContent + '" data-idname="' + element.idname + '" data-customaction=\'' + customAction + '\' style="background-image: url(\'' + element.icon + '\'); background-size: 80px 80px;"><p class="name">' + element.name + '</p><p class="amount">' + numberWithCommas(element.amount) + '</p></div>');
      if (selectIdName && selectIdName == element.idname) {
        $("#items div").last().click()
      }
    });
  }
  if (item.notification == true) {
    Swal.fire(
      item.title,
      item.message,
      item.type
    )
  }
  if (item.weight && item.maxWeight) {
    $(".weight").html(item.weight + "/" + item.maxWeight + " kg");
  }
}

$(document).ready(function () {
  setTheme();
  $(".container").hide();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      init(item)
      open();
    }
    else if (item.show == false) {
      close();
    }
    else if (item.refresh) {
      open();
      init(item)
    }
  });
  document.onkeyup = function (data) {
    if (data.which == 27 || data.which == 112) {
      $.post('http://vrp_bag/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://vrp_bag/close', JSON.stringify({}));
  });
});

function open() {
  $("#home").css("display", "block");
  $(".container").fadeIn();
  clearSelectedItem();
}
function close() {
  $(".container").fadeOut();
  $("#home").css("display", "none");
  clearSelectedItem();
}

function selectItem(element) {
  clearSelectedItem()
  itemName = element.dataset.name;
  itemDescription = element.dataset.description;
  itemWeight = element.dataset.weight;
  itemAmount = element.dataset.amount;
  itemIdname = element.dataset.idname;
  selectIdName = itemIdname
  $(element).css("background-color", "#27ae60");
  $('#customMenu').empty()
  if (element.dataset.customaction) {
    var customActionList = JSON.parse(element.dataset.customaction)
    customActionList.forEach(e => {
      $('#customMenu').append(`<button class="function" onclick="customAction(this)" data-idname="${element.dataset.idname}" data-action="${e}">${e}</button></br>`)
    });
  }
  var infos = ''
  infos += '보유수량: ' + numberWithCommas(itemAmount) + '<br>'
  infos += '무게: ' + itemWeight + ' kg<br><br>'
  infos += itemDescription
  $('#itemName').html(itemName)
  $('#infos').html(infos)
  if (element.dataset.datacontent) {
    $('#infosEx').html(element.dataset.datacontent)
    $('#infosEx').show()
  }
  else {
    $('#infosEx').hide()
  }
  $('#amount').val('')
}
function customAction(element) {
  if (itemIdname) {
    $.post('http://vrp_bag/customAction', JSON.stringify({
      idname: element.dataset.idname,
      action: element.dataset.action
    }))
      .then(() => {
        clearSelectedItem();
      });
  } else {
    Swal.fire(
      '경고',
      '항목을 선택하십시오.',
      '경고'
    )
  }
}
function useItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      '경고',
      '유효한 숫자를 입력하십시오.',
      '경고'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      '경고',
      '입력 한 숫자가 인벤토리에있는 숫자보다 높습니다.',
      '경고'
    )
  } else {
    if (itemIdname) {
      $.post('http://vrp_bag/useItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
        .then(() => {
          clearSelectedItem();
        });
    } else {
      Swal.fire(
        '경고',
        '항목을 선택하십시오.',
        '경고'
      )
    }
  }
}

function dropItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      '경고',
      '유효한 숫자를 입력하십시오.',
      '경고'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      '경고',
      '입력 한 숫자가 인벤토리에있는 숫자보다 높습니다.',
      '경고'
    )
  } else {
    if (itemIdname !== null) {
      $.post('http://vrp_bag/dropItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
        .then(() => {
          clearSelectedItem();
        });
    } else {
      Swal.fire(
        '경고',
        '항목을 선택하십시오.',
        '경고'
      )
    }
  }
}

function giveItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      '경고',
      '유효한 숫자를 입력하십시오.',
      '경고'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      '경고',
      '입력 한 숫자가 인벤토리에있는 숫자보다 높습니다.',
      '경고'
    )
  } else {
    if (itemIdname) {
      $.post('http://vrp_bag/giveItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
        .then(() => {
          clearSelectedItem();
        });
    } else {
      Swal.fire(
        '경고',
        '항목을 선택하십시오.',
        '경고'
      )
    }
  }
}

function setAllAmount() {
  $("#amount").val(itemAmount);
}

function setTheme() {
  if (configs.theme.primary_color && configs.theme.secondary_color) {
    let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
    let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
    $(":root").attr("style", primary_color + secondary_color);
  }
}

function clearSelectedItem() {
  itemName = null;
  itemAmount = null;
  itemIdname = null;
  $("#items div").css("background-color", "transparent");
  $('#customMenu').empty()
  $('#itemName').html('')
  $('#infos').html('')
  $('#infosEx').html('')
  $('#infosEx').hide()
  $('#amount').val('')
}