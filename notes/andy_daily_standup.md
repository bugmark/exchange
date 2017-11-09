# Andy Daily Standup

Nov 6
----------------------------------------------

Target Outcomes
- [x] initial framework buildout
- [x] text extraction example
- [x] responsive page example

Nov 7
----------------------------------------------

Discussion
- designer availability?
- today's ethereum hack

Target Outcomes
- [x] project & contracts - rough-out
- [x] post offers (backend working - frontend style needs attention...)
- [ ] contract cross

Nov 8
----------------------------------------------

Discussion
- Q: what is the gray 'unfixed' badge on /issues?
- Q: what is the semantics of the green circle by Transfer?
- Q: how to calculate prices?
- Q: how to set maturation dates?
- Q: use all-or-none?

    Price calculation - FIXED offer: (payout pegged to 10 units)
    - invest 2 => BF 0.2  / BU 0.8
    - invest 5 => BF 0.5  / BU 0.5 
    - invest 8 => BF 0.8  / BU 0.2
    NOTE: CAN'T INVEST MORE THAN 10!  (0 and 10 are allowed...)

    Price calculation - UNFIXED offer: (payout pegged to 10 units)
    - invest 2 => BF 0.8  / BU 0.2
    - invest 5 => BF 0.5  / BU 0.5 
    - invest 8 => BF 0.2  / BU 0.8
    NOTE: CAN'T INVEST MORE THAN 10!  (0 and 10 are allowed...)

Target Outcomes
- [x] refactor offer/new pages
- [x] contract cross
- [ ] contract resolve

Nov 9
----------------------------------------------

Discussion
- http://bugmark.net/apidocs - working / pre-alpha

Target Outcomes
- [ ] working contract resolve
- [ ] code cleanup & refactoring
- [ ] add integration tests
