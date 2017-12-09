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

# Nov 09

- [x] docfix: working offer_bu, offer_bf
- [x] docfix: contract cross
- [x] all: add success flash messages after creating offer and contract
- [x] all: add devenv page

# Nov 10

- [x] feature spec: docfix projects
- [x] feature spec: docfix issues
- [x] feature spec: docfix offers
- [x] feature spec: docfix 
- [x] OfferCmd::CreateBuy with deposit
- [x] OfferCmd::CreateBuy - validation of deposit (spec)

# Nov 11

- [x] OfferCmd::CreateBuy - BF - validation of deposit (UI / error message)
- [x] OfferCmd::CreateBuy - BU - validation of deposit (UI / error message)

# Nov 12

- [x] Flash.now not working...
- [x] OfferCmd::CreateBuy - BF/BU - Add header error-message
- [x] OfferCmd::CreateBuy - BF/BU - Handle user low-balance error

# Nov 13

- [x] design "Be the first to invest"
- [x] implement "Be the first to invest"

# Nov 14

- [x] OfferCmd::CreateBuy - BF - feature spec
- [x] OfferCmd::CreateBuy - BU - feature spec

# Nov 15

- [x] add contract_cmd#create/clone/delete

# Nov 16

- [x] test (cross-expand) price limits
- [x] test (cross-expand) maturity dates and ranges

# Nov 17

- [x] add 'prototype_id' to Offers and Contracts
- [x] change 'revoke' to 'cancel'
- [x] test (offer-genbuy) cancel buy offers
- [x] test (offer-createbuy) user balance & reserves
- [x] test (offer-cancelbuy) user balance & reserves
- [x] test (offer-createbuy) user limits
- [x] add OfferCmd::Suspend command with tests

# Nov 18

- [x] add OfferCmd::CloneBuy with tests
- [x] test (cross-expand) user balance adjustments on cross
- [x] test (cross-expand) suspending over-reserve offers after crossing
- [x] test (cross-expand) generate re-offers
- [x] test (cross-expand) aon
- [x] test (cross-expand) reserve release

# Nov 19

- [x] test create sale offers
- [x] test cancel sale offers
- [x] test offer_sf and offer_su factories
- [x] write .select_summary (Offer, User, Position, Escrow, )
- [x] write #dump (escrow, amendment, user, offer, position, contract)
- [x] write #dumptree (escrow, position, amendment)
- [x] write #dt_escrow, #dt_amendment (contract)
- [x] every escrow must be attached to an amendment
- [x] every escrow must have a type
- [x] refactor sell-offer factories

# Nov 20

- [x] every cross must generate an amendment
- [x] every cross must generate 2 or more positions
- [x] test (cross-transfer) user balance adjustments

# Nov 21

- [x] test (cross-transfer) price limits
- [x] JJ Add pg_search
- [x] upgrade development to PostGres 10
- [x] upgrade production to PostGres10
- [x] test tsvector on hstore fields
- [x] test tsvector on jsonb fields

# Nov 22

- [x] attach README to repo
- [x] make README searchable
- [x] Repo text-index (later)
- [x] create project search action 
- [x] create project query
- [x] JJ Project Search

# Nov 24

- [x] move issue languages to jfields
- [x] rebuild project search

# Nov 25

- [x] display repo fields
- [x] feature spec for project search
- [x] update project contracts/offers
- [x] attach issue description

# Nov 26

- [x] Join project languages to issue search
- [x] JJ Issue Search
- [x] JJ add offers#index buttons
- [x] JJ add offers#index probability label
- [x] JJ add offers#index last-trade label
- [x] JJ build out /offers#show
- [x] JJ Trading Bot

# Nov 27

- [x] docfix: write a bot for testing and for demos
- [x] Bot Dashboard (/bot/home)
- [x] Add event log

# Nov 28

- [x] add /events&after=<id> route to API
- [x] GRAPHING InfluxDB Provisioning & Configuration
- [x] GRAHPING Grafana  Provisioning

# Nov 29

- [x] Configure Influx/Grafana
- [x] FEEDBACK: establish a demo page w/links to demos (CORE, BOT, DOCFIX, API)
- [x] FEEDBACK: link from home page to demo page
- [x] install jquery sparkline https://omnipotent.net/jquery.sparkline
- [x] install screencast software - kazam
- [x] GRAPHING InfluxDB Data Reload
- [x] GRAPHING Grafana  Configuration
- [x] GRAPHING Grafana  Chart Development
- [x] GRAPHING InfluxDB Data Export
- [x] GRAPHING Grafana  Chart Import

# Nov 30

- [x] FEEDBACK: write a draft demo script
- [x] FEEDBACK: add a link from /experiments to the demo script
- [x] FEEDBACK: record screencast demo with Kazam
- [x] FEEDBACK: post screencast demo Vimeo(uid=bugmvid@protonmail.com)
- [x] FEEDBACK: redirect successful login to referring page
- [x] FEEDBACK: update username for navbar

# Dec 01

- [x] FEEDBACK: separate NAV/login links for CORE, BOT and DOCFIX
- [x] FEEDBACK: every app has a authenticated welcome page
- [x] FEEDBACK: fix format for the sign-in page
- [x] FEEDBACK: add nav links to bot log page
- [x] FEEDBACK: add nav links to rebuild log page (decided not...)
- [x] FEEDBACK: add demo account information the sign-in page
- [x] FEEDBACK: update mad-libs interface

# Dec 02

- [x] JJ README overview on /projects
- [x] FEEDBACK: fix mad-libs render issues
- [x] FEEDBACK: turnoff refresh on most pages
- [x] FEEDBACK: date-select on mad-libs interface
- [x] FEEDBACK: use mad-libs interface for all offers
- [x] FEEDBACK: handle mad-libs errors (eg user over-balance)
- [x] JJ build out contracts#index
- [x] JJ build out contracts#show 

# Dec 03

- [x] JJ Offer sorting
- [x] JJ Contract sorting

# Dec 04

- [x] OfferSF Test: Enable specification of buy-offer in offer_sf_spec
- [x] OfferSF Test: Finish it off
- [x] API test-generate ruby bindings with Swagger-CodeGen 
- [x] JJ Update Demo Script

# Dec 05

- [x] Eliminate need for grafana password
- [x] Tweak madlibs wording
- [x] Add time-travel
- [x] FEEDBACK: build feature specs to drive mad-libs interfaces
- [x] add :offer_bu to create_buy_spec
- [x] Pick up comments
- [x] Add comments to all issues

# Dec 06

- [x] Add w/e times to BugmTime
- [x] Offer/create script - use w/e times randomly
- [x] Create offer w/maturation date - 1 day prior and 1 day following
- [x] Bot: use w/e times random
- [x] Show list of open offers on an issue, grouped by maturation date
- [x] Add Chart.js
- [x] JJ Contract Sparkline
- [x] fix www.bugmark.net SSL cert

# Dec 07

- [x] Create histogram for Offer Depth chart
- [x] Streamline the docfix login
- [x] docfix: create take_bu, take_bf
- [x] docfix: add Jquery to dynamically update prices
- [x] docfix: cleanup offer pages
- [x] OfferBuy: rename 'stake' to 'deposit'
- [x] OfferBuy: add a 'profit' options
- [x] add an API action for updating EtherScan url

# Dec 08

- [x] Tune up demo script
- [x] docfix: fix resolve/close

- [ ] docfix: add inbox

- [ ] docfix: do cross immediately upon match offer creation

- [ ] Add GitHub PR / Issue Close screenshots

- [ ] docfix: add escrows to contract

- [ ] Add user inbox
- [ ] Add a 'take' button to an offer view

- [ ] Write a deployment plan

- [ ] JJ Profile Pages

- [ ] core: fix take link 

- [ ] FEEDBACK: reformat the registration page (add account wipe-out note)

- [ ] FEEDBACK: add content for the sign-in pages
- [ ] FEEDBACK: make a feature spec that follows the demo
- [ ] FEEDBACK: make a new offer attempt to cross immediately
- [ ] FEEDBACK: the offer amounts seem wrong
- [ ] FEEDBACK: should fixed-side offers be AON?

- [ ] auto-renew SSL cert

# TBD

- [ ] test (cross-transfer) partial positions
- [ ] test (cross-transfer) auto-suspended sale-offers
- [ ] test (cross-transfer) sell-offer re-offers

- [ ] METRICS: add Georg command-data capture
- [ ] METRICS: add Georg stats capture with cron process

- [ ] test (cross-reduce)     user balance adjustments
- [ ] test (cross-reduce)     auto-suspend sale-offers
- [ ] test (contract-resolve) user balance adjustments

- [ ] add ContractCmd::Create with tests
- [ ] add ContractCmd::Clone with tests
- [ ] add ContractCmd::Delete with tests

- [ ] create a staging server

- [ ] add OfferCmd::CloneSell with tests
- [ ] test for 0/100 and 100/0 pricing

- [ ] core: expose AON in UI
- [ ] core: expose poolable in UI

- [ ] docfix: test event replay
- [ ] docfix: get blockchain reporting working
- [ ] docfix: write events to testnet

- [ ] move GH API Key to .env

- [ ] docfix: move offer pages to modals
- [ ] docfix: get notification emails working
- [ ] docfix: add designer registration page
- [ ] docfix: get labels working
- [ ] docfix: style pagination links (issue, offer) 
- [ ] docfix: get full-text issue search working
- [ ] docfix: get GitHub signup working
- [ ] docfix: design wallet structure
- [ ] docfix: get stripe integration working
- [ ] docfix: BitCoin integration
- [ ] docfix: Eth integration

- [ ] core: implement a graph
- [ ] core: get sell/cross working
- [ ] core: write Commit#resolve
- [ ] core: implement all-or-none
- [ ] core: reset the data from the UI
- [ ] core: reset the contract maturation date

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

- [ ] core: rewrite the exchange in elixir
- [ ] core: add GraphQL API
- [ ] core: wrote standalone UI in Sinatra
