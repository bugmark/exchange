setVal = ()->
  side       = $('#oSide').html()
  in_stake   = $('#inStake').val()
  in_vol     = $('#inVol').val()
  validateBtn(in_stake, in_vol)
  base_price = in_stake / in_vol
  [f_price, u_price] = switch side
    when "fixed" then [base_price, 1.0 - base_price]
    else              [1.0 - base_price, base_price]
  $('#dVol').html(in_vol)
  $('#dF').html(f_price)
  $('#dU').html(u_price)

validate = (in_stake, in_vol)->
  console.log "INS <#{in_stake}> INV <#{in_vol}>"
  return [false, "Volume must be > 0"] if in_vol < 1
  return [false, "Stake must be > 0"] if in_stake < 1
  return [false, "Stake must be < volume"] if in_stake >= in_vol
  [true, "ok"]

validateBtn = (in_stake, in_vol)->
  [valid, msg] = validate(in_stake, in_vol)
  if valid
    $('#errMsg').html("")
    $('#sBtn').removeClass("disabled")
  else
    $('#errMsg').html(msg)
    $('#sBtn').addClass("disabled")

$(document).ready ->
  setVal()
  $('.token-field').keyup ->
    setVal()
