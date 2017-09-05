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
- [DONE] rename 'form' to 'commands'
- [DONE] add a 'ref' field to all objects (uuref and exref)
- [DONE] write a Projection class
- [DONE] make all the Commands emit events
- write a user registration controller that uses commands
- build tests to save and re-play events
- add the event stream to the UI (account history, etc.)
- integrate with blockchain

Next Actions:
- [DONE] add CronJobs scripts
- [DONE] update CronJobs on production deploy

# Jul 31

Next Actions:
- [DONE] add a resolve command and contract support methods
- [DONE] add a resolve script
- [DONE] launch resolve script from production cron
- [DONE] add a weekly account top-up script
- [DONE] launch top-up script from production cron

# Aug 01

Next Actions:
- [DONE] add repo add/remove
- [DONE] add repo sync
- [DONE] add repo sync to cron
- [DONE] UI: add font awesome
- [DONE] UI: add table sorting
- [DONE] UI: change 'forecast' to 'contract'
- [DONE] UI: convert layout to slim
- [DONE] UI: add javascript block

# Aug 02

Next Actions:
- [DONE] Add a bugmark-guides repo
- [DONE] Add a bugmark-slides repo
- [DONE] UI: fix repo show page
- [DONE] UI: fix bug show page
- [DONE] UI: fix contract show page
- [DONE] UI: add a contract resolve link
- [DONE] UI: set clock to pacific time

# Aug 03

- [DONE] UI: color-code contract status
- [DONE] add tests for contract-resolution use cases
- [DONE] UI: add days/hours/minutes for contract maturation
- [DONE] UI: add selective display of actions
- [DONE] UI: selective repo destroy (no contracts)

# Aug 04

- [DONE] Fix demo bugs

# Aug 07

- [TODO] Publish Contract Design V2

# Aug 08

- [DONE] Add feature specs

# Aug 19

- [DONE] Event sourcing full implementation

# Aug 24

- [DONE] Publish Trading Mechanics V2 plan

# Aug 25

- [DONE] Push V2 branch

# Aug 26

- [DONE] add bid/ask models
- [DONE] UI: upgrade to bootstrap beta

# Sep 04

- [TODO] build out bids/new page
- [TODO] build out asks/new page
- [TODO] build out Offers and Contracts page

# TBD

- [TODO] contract change from forecast to repo type
- [TODO] UI: link from bugmark.net to documentation
- [TODO] UI: create intro slide deck
