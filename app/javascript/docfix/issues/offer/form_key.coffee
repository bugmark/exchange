setProfit = ()->
  inDep = parseInt($('#inDep').val())
  hiVol = parseInt($('#hiVol').val())
  inPro = hiVol - inDep
  $('#inPro').val(inPro)
  tLbl(inDep, hiVol, inPro)

setVal = ()->
  side       = $('#oSide').html()
  inDep     = parseInt($('#inDep').val())
  in_pro     = parseInt($('#inPro').val())
  validateBtn(inDep, in_vol)
  tLbl(inDep, in_vol)
  base_price = twoDec(inDep / in_vol)
  [f_price, u_price] = switch side
    when "fixed" then [base_price, twoDec(1.0 - base_price)]
    else              [twoDec(1.0 - base_price), base_price]
  tVal(inDep, in_vol, in_pro)

validate = (deposit, volume)->
  return [false, "Profit must be greater than 0"   ] unless volume  > 0
  return [false, "Deposit must be greater than 0"  ] unless deposit > 0
  return [false, "Deposit must be less than Profit"] unless deposit < volume
  [true, "ok"]

validateBtn = (in_dep, in_vol)->
  [valid, msg] = validate(in_dep, in_vol)
  if valid
    $('#errMsg').html("")
    $('#sBtn').removeClass("disabled").removeClass("strikeout")
  else
    $('#errMsg').html(msg)
    $('#sBtn').addClass("disabled").addClass("strikeout")

tVal = (dep, vol, pro)->
  $('.dVol').html(in_vol)
  $('.dPro').html(in_vol - inDep)
  $('.dF').html(f_price)
  $('.dU').html(u_price)

tLbl = (dep, vol, pro)->
  ss = if dep == 1 then "" else "s"
  sv = if vol == 1 then "" else "s"
  sp = if pro == 1 then "" else "s"
  $('#sLbl').html(ss)
  $('#vLbl').html(sv)
  $('#pLbl').html(sp)

twoDec = (num)->
  Math.round(num * 100) / 100

$(document).ready ->
  setProfit()
#  $('.token-field').keyup ->
#    setVal()
