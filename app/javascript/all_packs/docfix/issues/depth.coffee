Chart = require "chart.js"

$(document).ready ->
  ctx = $('#depthChart')
  myChart = new Chart(ctx,
    type: 'bar'
    data:
      labels: ["10","20","30","40","50","60","70","80","90"]
      datasets: [{
        backgroundColor: "red"
        label:           "Unfixed"
        data: window.Volumes.unfixed
      },
      {
        backgroundColor: "blue"
        label:           "Fixed"
        data: window.Volumes.fixed
      }]
    options:
      responsive: false
      legend: false
      tooltips: false
      scales:
        xAxes: [{stacked: true}]
        yAxes: [{stacked: true}]
  )


