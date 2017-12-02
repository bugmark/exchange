setClick = (id)->
  idStr = "##{id}"
  $('.bc').removeClass("active")
  $(idStr).addClass("active")
  data = $(idStr).attr("data-md")
  $("#hMat").val(data)

$(document).ready ->
  setClick("btn1")
  $('.bc').click (ev)->
    ev.preventDefault()
    tgtId = ev.target.id
    setClick(tgtId)
