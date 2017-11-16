# Andy Daily Standup

Mon Nov 6
----------------------------------------------

Target Outcomes for Nov 6
- [x] initial framework buildout
- [x] text extraction example
- [x] responsive page example

Tue Nov 7
----------------------------------------------

Discussion
- designer availability?
- today's ethereum hack

Target Outcomes for Nov 7
- [x] project & contracts - rough-out
- [x] post offers (backend working - frontend style needs attention...)
- [ ] contract cross

Wed Nov 8
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

Target Outcomes for Nov 8
- [x] refactor offer/new pages
- [x] contract cross
- [ ] contract resolve

Thu Nov 9
----------------------------------------------

Discussion
- http://bugmark.net/apidocs - working / pre-alpha

Target Outcomes for Nov 9
- [ ] working contract resolve
- [ ] code cleanup & refactoring
- [ ] add integration tests

Fri Nov 10
----------------------------------------------

Discussion
- got sidetracked yesterday :-|
- content pages on https://github.com/mvscorg/bugmark

    app/views/static/_home_content.html.slim
    app/views/docfix/homes/_docfix_about.html.slim  
    app/views/docfix/homes/_docfix_contact.html.slim  
    app/views/docfix/homes/_docfix_show.html.slim  
    app/views/docfix/homes/_docfix_terms.html.slim  
    
 - devenv page - see https://github.com/mvscorg/bugmark/README.md
 
 Target Outcomes for Nov 10
 - [x] working contract resolve
 - [x] add integration tests
 - [ ] code cleanup & refactoring (partial)
 
Mon Nov 13
----------------------------------------------

Discussion - changes to support Docfix design...
- at the API level, when making an offer you can specify a price OR a stake
- internally, we calculate & store a price
- validation rule: 0 <= stake <= volume
- changed the word 'invest' to 'stake' for internal consistency (new BF/BU)

Goals for the Week
- [ ] all trading paths working
- [ ] logging to ethereum-testnet
- [ ] trading sessions in our standups

Target Outcomes Nov 13
- [x] finish code cleanup / refactoring
- [x] implement "Be the first to invest"
- [ ] test re-offers, sale offers, cancel sales, suspensions, 0/100 pricing, ...
