Chart = require "chart.js"

chartFor = require "docfix/chart_for"

$(document).ready ->
  chartFor(Vals.f1, Vals.u1, "#dc0")


