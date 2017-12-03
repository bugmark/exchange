setVal = ()->
  side       = $('#oSide').html()
  in_stake   = parseInt($('#inStake').val())
  in_vol     = parseInt($('#inVol').val())
  validateBtn(in_stake, in_vol)
  tLbl(in_stake, in_vol)
  base_price = twoDec(in_stake / in_vol)
  [f_price, u_price] = switch side
    when "fixed" then [base_price, twoDec(1.0 - base_price)]
    else              [twoDec(1.0 - base_price), base_price]
  $('.dVol').html(in_vol)
  $('.dF').html(f_price)
  $('.dU').html(u_price)

validate = (stake, volume)->
  console.log "STAKE <#{stake}> VOLUME <#{volume}>"
  return [false, "Volume must be greater than 0" ] unless volume > 0
  return [false, "Stake must be greater than 0"  ] unless stake  > 0
  return [false, "Stake must be less than volume"] unless stake  <  volume
  [true, "ok"]

validateBtn = (in_stake, in_vol)->
  [valid, msg] = validate(in_stake, in_vol)
  if valid
    console.log "VALID"
    $('#errMsg').html("")
    $('#sBtn').removeClass("disabled").removeClass("strikeout")
  else
    console.log "NOT VALID"
    $('#errMsg').html(msg)
    $('#sBtn').addClass("disabled").addClass("strikeout")

tLbl = (stake, vol)->
  ss = if stake == 1 then "" else "s"
  sv = if vol == 1 then "" else "s"
  $('#sLbl').html(ss)
  $('#vLbl').html(sv)

twoDec = (num)->
  Math.round(num * 100) / 100

$(document).ready ->
  setVal()
  $('.token-field').keyup ->
    setVal()
