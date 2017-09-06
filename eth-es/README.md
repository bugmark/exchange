
# need to write events to a smart contract and then read them out again.

EVENTS:

- user

- repo

- bug

BugCreate


- bid


- cross

IMPLEMENTATION CHOICES:
- top-level container(s):  map, array
- inner objects(s): structs, maps
- use containment or references between objects?
- all events need timestamps, yes?
- how to enforce ordering?  what happens if two insert transactions happen
  in the same block?
- should different events be:
  a) different structs
  b) different types in an enum
  c) native solidity events ( are these readable historically ? )








https://ethereum.stackexchange.com/questions/15998/what-is-the-best-practice-to-store-and-retreive-large-data-in-solidity-smart-contracts







