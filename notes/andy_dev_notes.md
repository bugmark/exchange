# Jul 30

CQRS Design:
- commands create events which are saved in an event store
- events are persisted by a Projection object
- events have a cryptographic signature - merkle-tree style
- object references - generate object UUID reference *in the client*
- `SecureRandom.uuid`
- events are isomorphic with Solidity contract events
- events can come from Rails app or Blockchain
 
CQRS TODO:
- [DONE] rename 'form' to 'commands'
- [DONE] add a 'ref' field to all objects (uuref and exref)
- write a user registration controller that uses commands
- write a Projection class
- make all the Commands emit events
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

- [TODO] UI: add a contract resolve link

- [TODO] UI: cleanup documentation
- [TODO] UI: link from bugmark.net to documentation
- [TODO] UI: create intro slide deck

- [TODO] END TO END TESTING

- [TODO] UI: set clock to pacific time
- [TODO] UI: color-code contract status
