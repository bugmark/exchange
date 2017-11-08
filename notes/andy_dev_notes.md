# Jul 30

CQRS Design:
- commands create events which are saved in an event store
- events are persisted by a Projection object
- events have a cryptographic signature - merkle-tree style
- object references - generate object UUID reference *in the client*
- "SecureRandom.uuid"
- events are isomorphic with Solidity contract events
- events can come from Rails app or Blockchain
 
CQRS TODO:
- [x] rename 'form' to 'commands'
- [x] add a 'ref' field to all objects (uuref and exref)
- [x] write a Projection class
- [x] make all the Commands emit events
- write a user registration controller that uses commands
- build tests to save and re-play events
- add the event stream to the UI (account history, etc.)
- integrate with blockchain

Next Actions:
- [x] add CronJobs scripts
- [x] update CronJobs on production deploy

# Jul 31

Next Actions:
- [x] add a resolve command and contract support methods
- [x] add a resolve script
- [x] launch resolve script from production cron
- [x] add a weekly account top-up script
- [x] launch top-up script from production cron

# Aug 01

Next Actions:
- [x] add repo add/remove
- [x] add repo sync
- [x] add repo sync to cron
- [x] UI: add font awesome
- [x] UI: add table sorting
- [x] UI: change 'forecast' to 'contract'
- [x] UI: convert layout to slim
- [x] UI: add javascript block

# Aug 02

Next Actions:
- [x] Add a bugmark-guides repo
- [x] Add a bugmark-slides repo
- [x] UI: fix repo show page
- [x] UI: fix bug show page
- [x] UI: fix contract show page
- [x] UI: add a contract resolve link
- [x] UI: set clock to pacific time

# Aug 03

- [x] UI: color-code contract status
- [x] add tests for contract-resolution use cases
- [x] UI: add days/hours/minutes for contract maturation
- [x] UI: add selective display of actions
- [x] UI: selective repo destroy (no contracts)

# Aug 04

- [x] Fix demo bugs

# Aug 07

- [x] Publish Contract Design V2

# Aug 08

- [x] Add feature specs

# Aug 19

- [x] Event sourcing full implementation

# Aug 24

- [x] Publish Trading Mechanics V2 plan

# Aug 25

- [x] Push V2 branch

# Aug 26

- [x] add bid/ask models
- [x] UI: upgrade to bootstrap beta

# Sep 05

- [x] add etag field to repo and bug as xfields

# Sep 06

- [x] add user authentication to GitHub calls
- [x] add conditional fetch (etag) to GitHub calls
- [x] add a GitHub api wrapper class (record calls and rate limits)
- [x] add VCR mocking for GitHub testing
- [x] create bid/ask commands
- [x] create bid/ask loading scripts
- [x] build out bids/new page
- [x] build out asks/new page
- [x] contract change from forecast to repo type
- [x] build out Offers page                    

# Sep 07

- [x] create a Bid#cross method
- [x] create ContractCmd::Cross
- [x] create script/data/contract_load

# Sep 08

- [x] build out Contracts page
- [x] build out user trading page
- [x] add specs for models, commands, features
- [x] show bid/ask token amounts in contract

# Sep 09

- [x] test multi-party contracts
- [x] constrain crosses by token amounts - partial fill
- [x] create ContractCmd::Resolve
- [x] fix contract page parameters
- [x] add resolve button to /contracts page

# Sep 11

- [x] add ask/cross button to /offers page

# Sep 12

- [x] fix VCR configuration
- [x] feature specs for all pages

# Sep 13

- [x] enable a prediction (dynamic) contract type
- [x] add buy-side odds
- [x] add a forecasts page
- [x] add cross button to offers#index
- [x] add cross button to asks#show
- [x] rename ContractCmd to ContractCmd
- [x] rename 'contracts' to 'rewards'

# Sep 23

- [x] add namespaces for "core" and "bugfix" apps
- [x] add home page for "core" and "bugfix"

# Oct 3

- [x] all tests pass

# Oct 5

- [x] build ContractCmd::Cross

# Oct 6

- [x] render contract/show
- [x] get rid of bug presence in UI

# Oct 7

- [x] add contract maturation_range for offers
- [x] add contract maturation date with range date - 2 days

# Oct 8

- [x] update design for reselling and position allocation

# Oct 9

- [x] add volume and price in offer/new
- [x] add maturation_range for offers/new

# Oct 10

- [x] add documentation to bid/ask new
- [x] fix url on bug#show
- [x] add bid-count (with link) to bug#show
- [x] add ask-count (with link) to bug#show

# Oct 12

- [x] finalize the contract design

# Oct 13

- [x] rename 'match params' to 'statement'
- [x] add offers
- [x] add positions
- [x] add escrows
- [x] add specs for escrows
- [x] add ERD diagram for Rails Models
- [x] add specs for positions
- [x] collapse 'bids/asks' into offers(?)
- [x] add specs for offers
- [x] offer: change 'bug_' to 'statement_'(?)

# Oct 14

- [x] design Position/Escrow/Offer commands
- [x] rebuild offer commands   (with specs)
- [x] build positions commands (with specs)
- [x] build escrow commands    (with specs)
- [x] add factories for bid_buy
- [x] add spec for bid-buy-factory
- [x] add factories for positions
- [x] add spec for position-factory
- [x] add factories for escrows
- [x] add spec for escrow-factory
- [x] add factories for ask_buy
- [x] add spec for ask_buy-factory
- [x] build out data loading scripts
- [x] get offer-page working
- [x] get bid/new and ask/new working
- [x] get bid/create and ask/create working
- [x] restore all feature specs

# Oct 15

- [x] add GraphViz for contract structures
- [x] add PaperTrail for object changes
- [x] bid_buy/ask_buy: design configurable reserves
- [x] refactor buy/sell offers
- [x] add user-reserves methods
- [x] bid_buy/ask_buy: generate reserves
- [x] bid_buy/ask_buy: add specs
- [x] write Offer::Buy.user_funds validation

# Oct 16

- [x] test Offer::Buy.user_funds validation
- [x] bid_buy/ask_buy: show reserves on user-detail page
- [x] combine bid_buy/ask_buy into offer_buy

# Oct 17

- [x] create statement fields
- [x] add specs for buy_ask_cmd
- [x] add specs for buy_bid_cmd
- [x] add factory_girl specs for all factories
- [x] create MatchUtils module methods
- [x] Define Overlap methods  (offer & contract)
- [x] Define Cross methods    (offer)
- [x] add price limits
- [x] add bid/ask date ranges
- [x] Test matching
- [x] Test overlapping
- [x] Test crossing
- [x] add matcher object for offers (GitHub, CVE, etc.)
- [x] cross: fix cross
- [x] cross: generate escrow
- [x] cross: generate positions
- [x] set default offer to non-poolable
- [x] auto-update Bug#stm_bug_id
- [x] build out data loading scripts for offers
- [x] run and edit UI

# Oct 18

- [x] merge buy_bid_cmd and buy_ask_cmd into offer_buy_cmd/create
- [x] write offer_buy_cmd/cancel with specs
- [x] test data-loading scripts
- [x] add specs for contract_cmd
- [x] build out data loading script for contracts
- [x] refactor escrows to use acts_as_list
- [x] change expiration and maturation date field names
- [x] update cross to use new escrow strategy 
- [x] /repo      - add offers   count/link
- [x] /repo      - add contract count/link
- [x] /repo/:id  - add bids/asks/contracts
- [x] /bug/:id   - namespace bug helpers
- [x] /bug/:id   - add offers/contracts
- [x] /offers    - make namespaced offers helper
- [x] /offers    - filter by repo
- [x] /offers    - filter by bug
- [x] /offers    - filter by user
- [x] /bids/:id  - ...
- [x] /asks/:id  - ...
- [x] /contracts - ...
- [x] /users/:id - show AVAILABLE_BALANCE
- [x] navbar     - show AVAILABLE_BALANCE
- [x] deploy to production

# Oct 19

- [x] test associations: positions, user, offer, sell offer
- [x] add transfer object
- [x] build sell-offer spec
- [x] make a transfer model & spec
- [x] test associations: transfer, selloffer, buyoffer, positions...
- [x] sale: add offer_sell_cmd/create
- [x] sale: add offer_sell_cmd/cancel
- [x] cross: add contract_cmd/cross_from_sell_ask
- [x] put 'my positions' on /users/:id

# Oct 20

- [x] specify cross methods

# Oct 21

- [x] add offer#qualified_counteroffer methods
- [x] clean up specs
- [x] create Bundle
- [x] write new cross

# Oct 22

- [x] define Amendment::Expand
- [x] define Amendment::Transfer
- [x] define Amendment::Reduce
- [x] define Amendment::Resolve
- [x] write Amendment spec
- [x] update contract spec
- [x] add timestamps to all models

# Oct 23

- [x] write Amendment::Expand
- [x] add amendment_id to offer, position, escrow
- [x] add escrow types
- [x] write Commit#expand
- [x] test Bundle
- [x] test Commit
- [x] test ContractCmd::Cross
- [x] cross: enable partial volume match
- [x] cross: enable poolable offers
- [x] cross: generate re-offers
- [x] cross: add sell/bid=>sell/ask cross
- [x] cross: add buy/bid=>buy/ask cross
- [x] cross: make cross match buy and sell
- [x] get volume cancellation working

# Oct 24

- [x] write Commit#transfer
- [x] write Commit#reduce
- [x] /offers        - cross | retract | take
- [x] /offers/:id    - cross | retract | take 

# Oct 25

- [x] create /sell_offers/new?position_id=N
- [x] fix position volume bug
- [x] /users/:id/positions - sell
- [x] finalize /sell_offers/new and /sell_offers/controller
- [x] fix sell offer generation

# Oct 26

- [x] turn off pooling
- [x] turn off re-offers
- [x] turn off label search
- [x] fix escrow value
- [x] commit: implement refund release
- [x] commit: implement reoffer generation
- [x] commit: implement escrow capture
- [x] commit: suspend invalid offers
- [x] cross: handle release of reserves
- [x] fix price generation problem
- [x] remove unused statement fields
- [x] /users/:id   resolve
- [x] /contacts      - resolve
- [x] /contracts/:id - resolve
- [x] laptop dev env
- [x] add a signups page

# Nov 03

- [x] rename offer classes

# Nov 04

- [x] docfix: add docfix menus

# Nov 05

- [x] docfix: break out home-page text for editors
- [x] docfix: add responsive classes for phone rendering
- [x] docfix: get issue pagination working

# Nov 06

- [x] docfix: first implementation of profile and offer pages
- [x] core: add restful API with Grape (/api/v1/docs, /api/v1/bugs.json)
- [x] core: use swagger for restful api docco (/apidocs)

# Nov 07

- [x] docfix: add project page
- [x] docfix: add contract page
- [x] docfix: grab project languages
- [x] docfix: grab issue labels
- [x] core:   refactor offer associations (bid/ask > BF/BU)
- [x] docfix: post offers

# Nov 08

- [ ] docfix: contract cross
- [ ] docfix: contract resolve
- [ ] core:   contract resolve

- [ ] all: add success flash messages after creating offer and contract

- [ ] docfix: write a bot for testing and for demos

- [ ] add :offer_bu to create_buy_spec
- [ ] docfix: add Jquery to dynamically update prices
- [ ] docfix: cleanup offer pages
- [ ] docfix: move offer pages to modals

# TBD

- [ ] docfix: get notification emails working
- [ ] docfix: add designer registration page
- [ ] docfix: get labels working
- [ ] docfix: style pagination links (issue, offer) 
- [ ] docfix: get full-text issue search working
- [ ] docfix: get GitHub signup working
- [ ] docfix: design wallet structure
- [ ] docfix: get stripe integration working
- [ ] docfix: get blockchain reporting working
- [ ] docfix: BitCoin integration
- [ ] docfix: Eth integration

- [ ] core: implement a trading bot
- [ ] core: implement a graph
- [ ] core: get sell/cross working
- [ ] core: write Commit#resolve
- [ ] core: implement all-or-none
- [ ] core: reset the data from the UI
- [ ] core: write a trading bot
- [ ] core: reset the contract maturation date

- [ ] core: get grafana working with postgres
- [ ] core: add repo sync
- [ ] core: bid_buy/ask_buy: add suspended offers to the user-detail page
- [ ] core: feature specs for sell, take and cross actions
- [ ] core: generate contract-graph
- [ ] core: add cron process for contract cross
- [ ] core: add cron process for contract resolve
- [ ] core: enable event replay
- [ ] core: Restful API - generate user key
- [ ] core: Restful API - add rate limiting
- [ ] core: Restful API
- [ ] core: Restful API ruby bindings with rest-client
- [ ] core: Restful API CLI and Ruby Gem
- [ ] core: add GraphQL API
