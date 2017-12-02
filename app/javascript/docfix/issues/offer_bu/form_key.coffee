setVal = ()->
  side       = $('#oSide').html()
  in_stake   = $('#inStake').val()
  in_vol     = $('#inVol').val()
  base_price = in_stake / in_vol
  [f_price, u_price] = switch side
    when "fixed" then [base_price, 1.0 - base_price]
    else              [1.0 - base_price, base_price]
  $('#dVol').html(in_vol)
  $('#dF').html(f_price)
  $('#dU').html(u_price)

$(document).ready ->
  setVal()
  $('.token-field').keyup ->
    setVal()
