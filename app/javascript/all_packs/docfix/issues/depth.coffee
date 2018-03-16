Chart = require "chart.js"

chartFor = require "docfix/chart_for"

$(document).ready ->
  chartFor(Vals.f1, Vals.u1, "#dc0")
  chartFor(Vals.f2, Vals.u2, "#dc1")
  chartFor(Vals.f3, Vals.u3, "#dc2")
  chartFor(Vals.f4, Vals.u4, "#dc3")


