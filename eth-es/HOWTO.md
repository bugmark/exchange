testrpc &

truffle compile
truffle migrate
truffle exec commands/log_event.js 1 2 3
truffle exec commands/log_event.js 4 5 6
truffle exec commands/show_events.js
