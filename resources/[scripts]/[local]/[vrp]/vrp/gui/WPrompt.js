function numberFormat(inputNumber) {
  return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function numberToKorean(number) {
  var inputNumber = number < 0 ? false : number;
  var unitWords = ['', '만', '억', '조', '경', '해'];
  var splitUnit = 10000;
  var splitCount = unitWords.length;
  var resultArray = [];
  var resultString = '';

  for (var i = 0; i < splitCount; i++) {
    var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
    unitResult = Math.floor(unitResult);
    if (unitResult > 0) {
      resultArray[i] = unitResult;
    }
  }

  for (var i = 0; i < resultArray.length; i++) {
    if (!resultArray[i]) continue;
    resultString = String(resultArray[i]) + unitWords[i] + resultString;
  }

  return resultString;
}

var helpText = "[TAB]키를 누르면 완료됩니다."

function WPrompt() {
  var _this = this

  this.div = document.createElement("div");
  this.div.classList.add("wprompt");
  this.div.style.position = "absolute";

  this.div_title = document.createElement("h1");
  this.div_area = document.createElement("textarea");
  var _this = this;
  this.div_area.onblur = function () { _this.close(); }

  this.div_help = document.createElement("div");
  this.div_help.classList.add("help");

  this.div.appendChild(this.div_title);
  this.div.appendChild(this.div_area);
  this.div.appendChild(this.div_help);

  this.div_help.innerHTML = helpText;

  this.div_area.onkeyup = function () {
    var value = _this.div_area.value
    var value2 = parseInt(value)
    var html = ""
    if (value && value.length > 0 && value == value2 && value2 >= 1000) {
      html += helpText
      html += "<br><span class='subtext'>"
      html += "<strong>" + numberFormat(value2) + "</strong>";
      if (value2 >= 10000) {
        html += "<br>(" + numberToKorean(value2) + ")"
      }
      html += "</span>"
    } else {
      html += helpText;
    }
    _this.div_help.innerHTML = html
  }

  document.body.appendChild(this.div);

  this.div.style.display = "none";

  this.opened = false;
}

WPrompt.prototype.open = function (title, text) {
  this.close();

  this.div_title.innerHTML = title;
  this.div_area.value = text;
  this.div_help.innerHTML = helpText;
  this.opened = true;
  this.div.style.display = "flex";

  this.div.style.left = Math.round(document.body.offsetWidth / 100.5 - this.div.offsetWidth / 100.5) + "px";
  this.div.style.top = Math.round(document.body.offsetHeight / 2.0 - this.div.offsetHeight / 2.0) + "px";

  this.div_area.focus();
}

WPrompt.prototype.close = function () {
  if (this.opened) {
    this.result = this.div_area.value;
    if (this.onClose)
      this.onClose();

    this.div_area.blur();
    this.opened = false;
    this.div.style.display = "none";
  }
}
