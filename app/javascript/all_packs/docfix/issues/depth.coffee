Chart = require "chart.js"

chartFor = (df, du, id)->
  ctx = $(id)
  myChart = new Chart(ctx,
    type: 'bar'
    data:
      labels: ["10","20","30","40","50","60","70","80","90"]
      datasets: [{
        backgroundColor: "red"
        label:           "Unfixed"
        data: du
      },
        {
          backgroundColor: "blue"
          label:           "Fixed"
          data: df
        }]
    options:
      responsive: false
      legend:     false
      tooltips:   false
      scales:
        xAxes: [{stacked: true}]
        yAxes: [{stacked: true}]
  )

$(document).ready ->
  chartFor(Vals.f1, Vals.u1, "#dc0")
  chartFor(Vals.f2, Vals.u2, "#dc1")
  chartFor(Vals.f3, Vals.u3, "#dc2")
  chartFor(Vals.f4, Vals.u4, "#dc3")


