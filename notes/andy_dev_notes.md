# Aug 30

CQRS Design:
- commands create events which are saved in an event store
- events are persisted by a Projection object
- events have a cryptographic signature - merkle-tree style
- object references - generate object UUID reference *in the client*
- `SecureRandom.uuid`
 
CQRS Todo:
- rename 'form' to 'commands'
- add a 'ref' field to all objects
- write a custom user registration that uses commands
- write a Projection class
- build tests to save and re-play events

