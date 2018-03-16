Chart = require "chart.js"

$(document).ready ->
  ctx = $('#xChart')
  myChart = new Chart(ctx,
    type: 'bar'
    data:
      labels: ["10","20","30","40","50","","70","","90",""]
      datasets: [{
        backgroundColor: "blue"
        label:           "Unfixed"
        data: [0,0,0,0,0,2,3,5,12]
      },
      {
        backgroundColor: "red"
        label:           "Fixed"
        data: [9,3,9,3,2,0,0,0,0]
      }]
    options:
      responsive: false
      scales:
        xAxes: [{stacked: true}]
        yAxes: [{stacked: true}]
  )


