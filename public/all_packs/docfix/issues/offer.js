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
/******/ 	__webpack_require__.p = "/all_packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 263);
/******/ })
/************************************************************************/
/******/ ({

/***/ 255:
/* unknown exports provided */
/* all exports used */
/*!*************************************************************!*\
  !*** ./app/javascript/docfix/issues/offer/btn_click.coffee ***!
  \*************************************************************/
/***/ (function(module, exports) {

eval("var setClick;\n\nsetClick = function(id) {\n  var data, idStr;\n  idStr = \"#\" + id;\n  $('.bc').removeClass(\"active\");\n  $(idStr).addClass(\"active\");\n  data = $(idStr).attr(\"data-md\");\n  return $(\"#hMat\").val(data);\n};\n\n$(document).ready(function() {\n  return $('.bc').click(function(ev) {\n    var tgtId;\n    ev.preventDefault();\n    tgtId = ev.target.id;\n    return setClick(tgtId);\n  });\n});\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMjU1LmpzIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vLy4vYXBwL2phdmFzY3JpcHQvZG9jZml4L2lzc3Vlcy9vZmZlci9idG5fY2xpY2suY29mZmVlPzUyMTkiXSwic291cmNlc0NvbnRlbnQiOlsidmFyIHNldENsaWNrO1xuXG5zZXRDbGljayA9IGZ1bmN0aW9uKGlkKSB7XG4gIHZhciBkYXRhLCBpZFN0cjtcbiAgaWRTdHIgPSBcIiNcIiArIGlkO1xuICAkKCcuYmMnKS5yZW1vdmVDbGFzcyhcImFjdGl2ZVwiKTtcbiAgJChpZFN0cikuYWRkQ2xhc3MoXCJhY3RpdmVcIik7XG4gIGRhdGEgPSAkKGlkU3RyKS5hdHRyKFwiZGF0YS1tZFwiKTtcbiAgcmV0dXJuICQoXCIjaE1hdFwiKS52YWwoZGF0YSk7XG59O1xuXG4kKGRvY3VtZW50KS5yZWFkeShmdW5jdGlvbigpIHtcbiAgcmV0dXJuICQoJy5iYycpLmNsaWNrKGZ1bmN0aW9uKGV2KSB7XG4gICAgdmFyIHRndElkO1xuICAgIGV2LnByZXZlbnREZWZhdWx0KCk7XG4gICAgdGd0SWQgPSBldi50YXJnZXQuaWQ7XG4gICAgcmV0dXJuIHNldENsaWNrKHRndElkKTtcbiAgfSk7XG59KTtcblxuXG5cbi8vLy8vLy8vLy8vLy8vLy8vL1xuLy8gV0VCUEFDSyBGT09URVJcbi8vIC4vYXBwL2phdmFzY3JpcHQvZG9jZml4L2lzc3Vlcy9vZmZlci9idG5fY2xpY2suY29mZmVlXG4vLyBtb2R1bGUgaWQgPSAyNTVcbi8vIG1vZHVsZSBjaHVua3MgPSAzIl0sIm1hcHBpbmdzIjoiQUFBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTsiLCJzb3VyY2VSb290IjoiIn0=");

/***/ }),

/***/ 256:
/* unknown exports provided */
/* all exports used */
/*!************************************************************!*\
  !*** ./app/javascript/docfix/issues/offer/form_key.coffee ***!
  \************************************************************/
/***/ (function(module, exports) {

eval("var setProfitField, setTextLabels, twoDec, unfixedPrice, updateForm, validate, validateBtn;\n\nsetProfitField = function() {\n  var hiVol, inDep, inPro;\n  inDep = parseInt($('#inDep').val());\n  hiVol = parseInt($('#hiVol').val());\n  inPro = hiVol - inDep;\n  $('#inPro').val(inPro);\n  validateBtn(inDep, inPro);\n  return setTextLabels(inDep, inPro, hiVol);\n};\n\nupdateForm = function() {\n  var hiVol, inDep, inPro;\n  inDep = parseInt($('#inDep').val());\n  inPro = parseInt($('#inPro').val());\n  validateBtn(inDep, inPro);\n  hiVol = inDep + inPro;\n  $('#hiVol').val(hiVol);\n  return setTextLabels(inDep, inPro, hiVol);\n};\n\nunfixedPrice = function(dep, vol) {\n  var base, side;\n  side = $('#oSide').html();\n  base = twoDec(dep / vol);\n  if (side === \"fixed\") {\n    return twoDec(1.0 - base);\n  } else {\n    return base;\n  }\n};\n\nvalidate = function(deposit, profit) {\n  if (!(profit > 0)) {\n    return [false, \"Profit must be greater than 0\"];\n  }\n  if (!(deposit > 0)) {\n    return [false, \"Deposit must be greater than 0\"];\n  }\n  return [true, \"ok\"];\n};\n\nvalidateBtn = function(deposit, profit) {\n  var msg, ref, valid;\n  ref = validate(deposit, profit), valid = ref[0], msg = ref[1];\n  if (valid) {\n    $('#errMsg').html(\"\");\n    return $('#sBtn').removeClass(\"disabled\").removeClass(\"strikeout\");\n  } else {\n    $('#errMsg').html(msg);\n    return $('#sBtn').addClass(\"disabled\").addClass(\"strikeout\");\n  }\n};\n\nsetTextLabels = function(deposit, profit, volume) {\n  var sp, ss, sv;\n  console.log(deposit + \" > \" + profit + \" > \" + volume);\n  ss = deposit === 1 ? \"\" : \"s\";\n  sv = volume === 1 ? \"\" : \"s\";\n  sp = profit === 1 ? \"\" : \"s\";\n  $('#sLbl').html(ss);\n  $('#vLbl').html(sv);\n  $('#pLbl').html(sp);\n  $('.dVol').html(volume);\n  return $('.dU').html(unfixedPrice(deposit, volume));\n};\n\ntwoDec = function(num) {\n  return Math.round(num * 100) / 100;\n};\n\n$(document).ready(function() {\n  setProfitField();\n  return $('.token-field').keyup(function() {\n    return updateForm();\n  });\n});\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMjU2LmpzIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vLy4vYXBwL2phdmFzY3JpcHQvZG9jZml4L2lzc3Vlcy9vZmZlci9mb3JtX2tleS5jb2ZmZWU/OTczOCJdLCJzb3VyY2VzQ29udGVudCI6WyJ2YXIgc2V0UHJvZml0RmllbGQsIHNldFRleHRMYWJlbHMsIHR3b0RlYywgdW5maXhlZFByaWNlLCB1cGRhdGVGb3JtLCB2YWxpZGF0ZSwgdmFsaWRhdGVCdG47XG5cbnNldFByb2ZpdEZpZWxkID0gZnVuY3Rpb24oKSB7XG4gIHZhciBoaVZvbCwgaW5EZXAsIGluUHJvO1xuICBpbkRlcCA9IHBhcnNlSW50KCQoJyNpbkRlcCcpLnZhbCgpKTtcbiAgaGlWb2wgPSBwYXJzZUludCgkKCcjaGlWb2wnKS52YWwoKSk7XG4gIGluUHJvID0gaGlWb2wgLSBpbkRlcDtcbiAgJCgnI2luUHJvJykudmFsKGluUHJvKTtcbiAgdmFsaWRhdGVCdG4oaW5EZXAsIGluUHJvKTtcbiAgcmV0dXJuIHNldFRleHRMYWJlbHMoaW5EZXAsIGluUHJvLCBoaVZvbCk7XG59O1xuXG51cGRhdGVGb3JtID0gZnVuY3Rpb24oKSB7XG4gIHZhciBoaVZvbCwgaW5EZXAsIGluUHJvO1xuICBpbkRlcCA9IHBhcnNlSW50KCQoJyNpbkRlcCcpLnZhbCgpKTtcbiAgaW5Qcm8gPSBwYXJzZUludCgkKCcjaW5Qcm8nKS52YWwoKSk7XG4gIHZhbGlkYXRlQnRuKGluRGVwLCBpblBybyk7XG4gIGhpVm9sID0gaW5EZXAgKyBpblBybztcbiAgJCgnI2hpVm9sJykudmFsKGhpVm9sKTtcbiAgcmV0dXJuIHNldFRleHRMYWJlbHMoaW5EZXAsIGluUHJvLCBoaVZvbCk7XG59O1xuXG51bmZpeGVkUHJpY2UgPSBmdW5jdGlvbihkZXAsIHZvbCkge1xuICB2YXIgYmFzZSwgc2lkZTtcbiAgc2lkZSA9ICQoJyNvU2lkZScpLmh0bWwoKTtcbiAgYmFzZSA9IHR3b0RlYyhkZXAgLyB2b2wpO1xuICBpZiAoc2lkZSA9PT0gXCJmaXhlZFwiKSB7XG4gICAgcmV0dXJuIHR3b0RlYygxLjAgLSBiYXNlKTtcbiAgfSBlbHNlIHtcbiAgICByZXR1cm4gYmFzZTtcbiAgfVxufTtcblxudmFsaWRhdGUgPSBmdW5jdGlvbihkZXBvc2l0LCBwcm9maXQpIHtcbiAgaWYgKCEocHJvZml0ID4gMCkpIHtcbiAgICByZXR1cm4gW2ZhbHNlLCBcIlByb2ZpdCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiAwXCJdO1xuICB9XG4gIGlmICghKGRlcG9zaXQgPiAwKSkge1xuICAgIHJldHVybiBbZmFsc2UsIFwiRGVwb3NpdCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiAwXCJdO1xuICB9XG4gIHJldHVybiBbdHJ1ZSwgXCJva1wiXTtcbn07XG5cbnZhbGlkYXRlQnRuID0gZnVuY3Rpb24oZGVwb3NpdCwgcHJvZml0KSB7XG4gIHZhciBtc2csIHJlZiwgdmFsaWQ7XG4gIHJlZiA9IHZhbGlkYXRlKGRlcG9zaXQsIHByb2ZpdCksIHZhbGlkID0gcmVmWzBdLCBtc2cgPSByZWZbMV07XG4gIGlmICh2YWxpZCkge1xuICAgICQoJyNlcnJNc2cnKS5odG1sKFwiXCIpO1xuICAgIHJldHVybiAkKCcjc0J0bicpLnJlbW92ZUNsYXNzKFwiZGlzYWJsZWRcIikucmVtb3ZlQ2xhc3MoXCJzdHJpa2VvdXRcIik7XG4gIH0gZWxzZSB7XG4gICAgJCgnI2Vyck1zZycpLmh0bWwobXNnKTtcbiAgICByZXR1cm4gJCgnI3NCdG4nKS5hZGRDbGFzcyhcImRpc2FibGVkXCIpLmFkZENsYXNzKFwic3RyaWtlb3V0XCIpO1xuICB9XG59O1xuXG5zZXRUZXh0TGFiZWxzID0gZnVuY3Rpb24oZGVwb3NpdCwgcHJvZml0LCB2b2x1bWUpIHtcbiAgdmFyIHNwLCBzcywgc3Y7XG4gIGNvbnNvbGUubG9nKGRlcG9zaXQgKyBcIiA+IFwiICsgcHJvZml0ICsgXCIgPiBcIiArIHZvbHVtZSk7XG4gIHNzID0gZGVwb3NpdCA9PT0gMSA/IFwiXCIgOiBcInNcIjtcbiAgc3YgPSB2b2x1bWUgPT09IDEgPyBcIlwiIDogXCJzXCI7XG4gIHNwID0gcHJvZml0ID09PSAxID8gXCJcIiA6IFwic1wiO1xuICAkKCcjc0xibCcpLmh0bWwoc3MpO1xuICAkKCcjdkxibCcpLmh0bWwoc3YpO1xuICAkKCcjcExibCcpLmh0bWwoc3ApO1xuICAkKCcuZFZvbCcpLmh0bWwodm9sdW1lKTtcbiAgcmV0dXJuICQoJy5kVScpLmh0bWwodW5maXhlZFByaWNlKGRlcG9zaXQsIHZvbHVtZSkpO1xufTtcblxudHdvRGVjID0gZnVuY3Rpb24obnVtKSB7XG4gIHJldHVybiBNYXRoLnJvdW5kKG51bSAqIDEwMCkgLyAxMDA7XG59O1xuXG4kKGRvY3VtZW50KS5yZWFkeShmdW5jdGlvbigpIHtcbiAgc2V0UHJvZml0RmllbGQoKTtcbiAgcmV0dXJuICQoJy50b2tlbi1maWVsZCcpLmtleXVwKGZ1bmN0aW9uKCkge1xuICAgIHJldHVybiB1cGRhdGVGb3JtKCk7XG4gIH0pO1xufSk7XG5cblxuXG4vLy8vLy8vLy8vLy8vLy8vLy9cbi8vIFdFQlBBQ0sgRk9PVEVSXG4vLyAuL2FwcC9qYXZhc2NyaXB0L2RvY2ZpeC9pc3N1ZXMvb2ZmZXIvZm9ybV9rZXkuY29mZmVlXG4vLyBtb2R1bGUgaWQgPSAyNTZcbi8vIG1vZHVsZSBjaHVua3MgPSAzIl0sIm1hcHBpbmdzIjoiQUFBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7Iiwic291cmNlUm9vdCI6IiJ9");

/***/ }),

/***/ 263:
/* unknown exports provided */
/* all exports used */
/*!*************************************************************!*\
  !*** ./app/javascript/all_packs/docfix/issues/offer.coffee ***!
  \*************************************************************/
/***/ (function(module, exports, __webpack_require__) {

eval("__webpack_require__(/*! docfix/issues/offer/btn_click */ 255);\n\n__webpack_require__(/*! docfix/issues/offer/form_key */ 256);\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMjYzLmpzIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vLy4vYXBwL2phdmFzY3JpcHQvYWxsX3BhY2tzL2RvY2ZpeC9pc3N1ZXMvb2ZmZXIuY29mZmVlP2FjYmIiXSwic291cmNlc0NvbnRlbnQiOlsicmVxdWlyZShcImRvY2ZpeC9pc3N1ZXMvb2ZmZXIvYnRuX2NsaWNrXCIpO1xuXG5yZXF1aXJlKFwiZG9jZml4L2lzc3Vlcy9vZmZlci9mb3JtX2tleVwiKTtcblxuXG5cbi8vLy8vLy8vLy8vLy8vLy8vL1xuLy8gV0VCUEFDSyBGT09URVJcbi8vIC4vYXBwL2phdmFzY3JpcHQvYWxsX3BhY2tzL2RvY2ZpeC9pc3N1ZXMvb2ZmZXIuY29mZmVlXG4vLyBtb2R1bGUgaWQgPSAyNjNcbi8vIG1vZHVsZSBjaHVua3MgPSAzIl0sIm1hcHBpbmdzIjoiQUFBQTtBQUNBO0FBQ0E7Iiwic291cmNlUm9vdCI6IiJ9");

/***/ })

/******/ });