# Jul 30

CQRS Design:
- commands create events which are saved in an event store
- events are persisted by a Projection object
- events have a cryptographic signature - merkle-tree style
- object references - generate object UUID reference *in the client*
- `SecureRandom.uuid`
 
CQRS TODO:
- [DONE] rename 'form' to 'commands'
- [DONE] add a 'ref' field to all objects (uuref and exref)
- write a user registration controller that uses commands
- write a Projection class
- make all the Commands emit events
- build tests to save and re-play events

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

- [TODO] add repo add/remove
- [TODO] add repo sync

- [TODO] work on usability and documentation
- [TODO] compile user stories

- [TODO] generate an event stream for all commands
- [TODO] add the event stream to the UI (account history, etc.)

