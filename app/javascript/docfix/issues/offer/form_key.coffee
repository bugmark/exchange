setProfitField = ()->
  inDep = parseInt($('#inDep').val())
  hiVol = parseInt($('#hiVol').val())
  inPro = hiVol - inDep
  $('#inPro').val(inPro)
  validateBtn(inDep, inPro)
  setTextLabels(inDep, inPro, hiVol)

updateForm = ()->
  inDep   = parseInt($('#inDep').val())
  inPro   = parseInt($('#inPro').val())
  validateBtn(inDep, inPro)
  hiVol   = inDep + inPro
  $('#hiVol').val(hiVol)
  setTextLabels(inDep, inPro, hiVol)

unfixedPrice = (dep, vol)->
  side  = $('#oSide').html()
  base  = twoDec(dep / vol)
  if side == "fixed"
    twoDec(1.0 - base)
  else
    base

validate = (deposit, profit)->
  return [false, "Profit must be greater than 0"   ] unless profit  > 0
  return [false, "Deposit must be greater than 0"  ] unless deposit > 0
  [true, "ok"]

validateBtn = (deposit, profit)->
  [valid, msg] = validate(deposit, profit)
  if valid
    $('#errMsg').html("")
    $('#sBtn').removeClass("disabled").removeClass("strikeout")
  else
    $('#errMsg').html(msg)
    $('#sBtn').addClass("disabled").addClass("strikeout")

setTextLabels = (deposit, profit, volume)->
  console.log "#{deposit} > #{profit} > #{volume}"
  ss = if deposit == 1 then "" else "s"
  sv = if volume  == 1 then "" else "s"
  sp = if profit  == 1 then "" else "s"
  $('#sLbl').html(ss)
  $('#vLbl').html(sv)
  $('#pLbl').html(sp)
  $('.dVol').html(volume)
  $('.dU').html(unfixedPrice(deposit, volume))

twoDec = (num)->
  Math.round(num * 100) / 100

$(document).ready ->
  setProfitField()
  $('.token-field').keyup ->
    updateForm()
