$(document).ready ->
  $('.bc').click (ev)->
    ev.preventDefault()
    tgtId = ev.target.id
    $('.bc').removeClass("active")
    $("##{tgtId}").addClass("active")
