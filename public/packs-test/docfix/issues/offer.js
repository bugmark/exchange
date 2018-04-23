/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs-test/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 264);
/******/ })
/************************************************************************/
/******/ ({

/***/ 256:
/***/ (function(module, exports) {

var setClick;

setClick = function(id) {
  var data, idStr;
  idStr = "#" + id;
  $('.bc').removeClass("active");
  $(idStr).addClass("active");
  data = $(idStr).attr("data-md");
  console.log("CLICK " + data);
  return $("#hMat").val(data);
};

$(document).ready(function() {
  return $('.bc').click(function(ev) {
    var tgtId;
    ev.preventDefault();
    tgtId = ev.target.id;
    return setClick(tgtId);
  });
});


/***/ }),

/***/ 257:
/***/ (function(module, exports) {

var setProfitField, setTextLabels, twoDec, unfixedPrice, updateForm, validate, validateBtn;

setProfitField = function() {
  var hiVol, inDep, inPro;
  inDep = parseInt($('#inDep').val());
  hiVol = parseInt($('#hiVol').val());
  inPro = hiVol - inDep;
  $('#inPro').val(inPro);
  validateBtn(inDep, inPro);
  return setTextLabels(inDep, inPro, hiVol);
};

updateForm = function() {
  var hiVol, inDep, inPro;
  inDep = parseInt($('#inDep').val());
  inPro = parseInt($('#inPro').val());
  validateBtn(inDep, inPro);
  hiVol = inDep + inPro;
  $('#hiVol').val(hiVol);
  return setTextLabels(inDep, inPro, hiVol);
};

unfixedPrice = function(dep, vol) {
  var base, side;
  side = $('#oSide').html();
  base = twoDec(dep / vol);
  if (side === "fixed") {
    return twoDec(1.0 - base);
  } else {
    return base;
  }
};

validate = function(deposit, profit) {
  if (!(profit > 0)) {
    return [false, "Profit must be greater than 0"];
  }
  if (!(deposit > 0)) {
    return [false, "Deposit must be greater than 0"];
  }
  return [true, "ok"];
};

validateBtn = function(deposit, profit) {
  var msg, ref, valid;
  ref = validate(deposit, profit), valid = ref[0], msg = ref[1];
  if (valid) {
    $('#errMsg').html("");
    return $('#sBtn').removeClass("disabled").removeClass("strikeout");
  } else {
    $('#errMsg').html(msg);
    return $('#sBtn').addClass("disabled").addClass("strikeout");
  }
};

setTextLabels = function(deposit, profit, volume) {
  var sp, ss, sv;
  console.log(deposit + " > " + profit + " > " + volume);
  ss = deposit === 1 ? "" : "s";
  sv = volume === 1 ? "" : "s";
  sp = profit === 1 ? "" : "s";
  $('#sLbl').html(ss);
  $('#vLbl').html(sv);
  $('#pLbl').html(sp);
  $('.dVol').html(volume);
  return $('.dU').html(unfixedPrice(deposit, volume));
};

twoDec = function(num) {
  return Math.round(num * 100) / 100;
};

$(document).ready(function() {
  setProfitField();
  return $('.token-field').keyup(function() {
    return updateForm();
  });
});


/***/ }),

/***/ 264:
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(256);

__webpack_require__(257);


/***/ })

/******/ });