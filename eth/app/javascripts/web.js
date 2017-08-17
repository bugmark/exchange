import { default as Web3} from 'web3';

// ---------------------------------------------------------------------

window.Base = require("./base.js").default;

// ---------------------------------------------------------------------

window.addEventListener('load', function() {
  var w3 = Base.w3();
  Base.start(w3);
  Base.htmlBalance("balance");
  Base.consoleBalance();
  console.log("KONG", Base.kong);
});
