setClick = (id)->
  idStr = "##{id}"
  $('.bc').removeClass("active")
  $(idStr).addClass("active")
  data = $(idStr).attr("data-md")
  console.log "CLICK #{data}"
  $("#hMat").val(data)

$(document).ready ->
  $('.bc').click (ev)->
    ev.preventDefault()
    tgtId = ev.target.id
    setClick(tgtId)
