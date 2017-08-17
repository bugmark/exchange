// ---------------------------------------------------------------------

var Base = require("./base.js").default;

// ---------------------------------------------------------------------

module.exports = function(callback) {
  var w3 = Base.w3();
  Base.start(w3);
  Base.consoleBalance();
  console.log("KONG", Base.kong);
}

