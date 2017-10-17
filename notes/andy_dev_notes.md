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

- [x] add contract maturation_period for offers
- [x] add contract maturation date with range date - 2 days

# Oct 8

- [x] update design for reselling and position allocation

# Oct 9

- [x] add volume and price in offer/new
- [x] add maturation_period for offers/new

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

- [ ] Test matching
- [ ] Test overlapping
- [ ] Test crossing

- [ ] cross: generate escrow
- [ ] cross: generate positions
- [ ] cross: generate re-offers
- [ ] cross: generate contract-graph
- [ ] cross: suspend invalid offers
- [ ] cross: handle reserves and escrow transfer

- [ ] add specs for contract_cmd

- [ ] bid_buy/ask_buy: add a cancel command
- [ ] bid_buy/ask_buy: add suspended offers to the user-detail page

- [ ] add matcher object for offers (GitHub, CVE, etc.)
- [ ] fix cross
- [ ] fix resolve
- [ ] implement commands with correct amounts

# TBD

- [ ] add price limits
- [ ] add bid/ask date ranges

- [ ] add bid/cancel link on offers#index
- [ ] add ask/cancel link on offers#index
- [ ] add bid/cancel link on offers#show
- [ ] add ask/cancel link on offers#show

- [ ] create a bid/take link on offers#index
- [ ] create an ask/take link on offers#index
- [ ] create a bid/take link on offers#show
- [ ] create an ask/take link on offers#show

- [ ] enable bid-side resale
- [ ] enable ask-side resale

- [ ] add cron process for contract cross
- [ ] add cron process for contract resolve
- [ ] enable event replay

- [ ] UI: link from bugmark.net to documentation
- [ ] UI: create intro slide deck

- [ ] add API
- [ ] use swagger for api docco
