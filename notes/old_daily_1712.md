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

Thu Nov 16
----------------------------------------------

Discussion
- Next Mon: trading sessions looking good
- Ethereum logging the following week
- Talked with Malvika & Georg re: features for research

Target Outcomes Nov 16
- [ ] finish testing re-offers, sale offers, etc. etc.

Fri Nov 17
----------------------------------------------

Discussion
- Testing taking longer than expected 
- But making steady progress
- See 'andy_dev_notes.md' for outline of test paths
- Refactoring as I go - code is getting simpler
- I'll work on UI over the wkend
- Next Mon: trading sessions still looking good

Target Outcomes Nov 17
- [ ] finish testing re-offers, sale offers, etc.

Mon Nov 20
----------------------------------------------

Discussion
- Tests taking WAY more time than expected
- No trading today
- But making steady progress
- See 'andy_dev_notes.md' for outline of test paths

Testing Status
- buy<->buy (volume expansion) complete
- sell<->buy (volume transfer) in progress
- sell<->sell (volume reduction) not started

Choices - For Discussion
- complete transfer tests
- put reduction tests on hold
- then build UI
- then build ethereum integration 

Target Outcomes Nov 20
- [x] TBD depending on feedback

Mon Nov 21
----------------------------------------------

Decision from yesterday
- Priority One: JJ Demo Script (Demoware)
- Priority Two: Ethereum logging
- After that, resume back-end development and general build-out

Target Outcomes Nov 20
- [x] JJ Demo Progress

Mon Nov 27
----------------------------------------------

Target Outcomes from last week:
- [x] implement full-text search (repos, issues)
- [x] cleanup JJ demo pages
- [x] implement BOT and BOT dashboard (see /bot/home)

Discussion:
- other work opportunities / priorities

Target Outcomes Nov 27:
- [ ] JJ Demo - offer page cleanup
- [ ] JJ Demo - contract page cleanup

Tue Nov 28
----------------------------------------------

Discussion:
- We now generate user: <joe|jane>@bugmark.net pass: bugmark
- Still have user: test<1|2|3>@bugmark.net pass: bugmark
- Event log is now visible at https://bugmark.net/events
- Rich starts work today on TestNet logging

Target Outcomes Nov 28:
- [x] build out offer page
- [ ] build out contract page

Wed Nov 29
----------------------------------------------

Discussion:
- We have an api call to grab the event log
- docco at https://bugmark.net/apidocs
- https://bugmark.net/api/v1/events?after=10
- Rich is writing a script to poll for events and log to Ethereum TestNet
- InfluxDB and Grafana provisioning is done
- We've started writing data points to InfluxDB

I am exploring off-the-shelf Bootstrap templates:
- consistent UI with coherent styles
- pre-built widgets for sparklines, candlesticks, charts, etc.

Examples:
- https://getbootstrapadmin.com/remark/base/charts/sparkline.html
- https://wrapbootstrap.com/themes/admin

Target Outcomes Nov 29:
- [x] end-to-end flow: eliminate need to type URLs
- [ ] finish contract page
- [ ] working offer sort
- [ ] working contract sort

Thu Nov 30
----------------------------------------------

Discussion:
- Streamlined nav with 'experiments' page
- Installed jquery sparklines
- Generating time-series data
- First Grafana graphs are live
- Found screencasting software

Target Outcomes Nov 30:
- [x] publish first draft demo script
- [x] refactor login redirect
- [ ] build mad-libs interface
- [ ] add sparkline to offer pages

Fri Dec 01
----------------------------------------------

Discussion:
- What is best way to select Offer Date?

Target Outcomes Dec 01:
- [x] working mad-libs interface
- [ ] add sparkline to offer pages
- [ ] working offer-sort and contract-sort
- [ ] finish contract pages

Sat Dec 02
----------------------------------------------

Discussion:
- Added webpacker-based javascript build

Target Outcomes Dec 02:
- [x] complete mad-libs interface
- [x] complete contract pages
- [ ] working offer-sort and contract-sort
- [ ] add sparklines to offer pages

Sun Dec 03
----------------------------------------------

Discussion:
- turned off refresh on most pages
- should fixed-side offers be AON?
- confirm: should new offers attempt to cross ASAP?
- question: what about contract resolution?

Target Outcomes Dec 03:
- [x] working offer-sort and contract-sort
- [ ] add sparklines to offer pages
- [ ] finish demo script

Mon Dec 04
----------------------------------------------

Discussion:
- let's discuss demo use-cases - what do we want?
- what should sparklines and candlesticks show for offers?
- what should sparklines and candlesticks show for contracts? (escrow prices...)
- I'm going to create a deployment plan

Target Outcomes Dec 04:
- [x] tweak demo script - per discussion
- [ ] sparklines  - per discussion

Tue Dec 05
----------------------------------------------

Discussion:
- API language binding: looking good!
- OfferSF and TransferCross and ReduceCross specs are now working
- question: how to demo GH PR and GH issue close?
- question: should we change 'stake' to 'deposit'? (YES)

Planned Software Changes:
- TimeTravel
- User Inbox
- Show OpenOffers on Issues

Target Outcomes Dec 05:
- [x] Tweak demo script
- [x] Add TimeTravel
- [ ] Tweak sparklines

Wed Dec 06
----------------------------------------------

Discussion:
- Grafana graphs are visible w/o password (http://bugmark.net:3030)

Target Outcomes Dec 06:
- [x] Add depth chart
- [x] Add sparklines
- [x] Add ability to close issues in demo
- [ ] Add contract resolution and payout

Thu Dec 07
----------------------------------------------

Discussion:
- bot speed increased from 20 seconds to 5 seconds
- bot offer maturity dates distributed across the four maturation periods
- bot offer volumes distributed between 50 and 100
- Timewarp @ /bot/time 1) jumps date 2) closes issues 3) resoves contracts (tbd)

Target Outcomes Dec 07:
- [x] Generate depth-chart data
- [x] Finish demo script
- [ ] Add contract resolution and payout

Fri Dec 08
----------------------------------------------

Discussion:
- added API call to post EtherScan url
- added Link to EtherScan page on /events
- updated wording on create-offer page
- changed login redirect to /docfix

Target Outcomes Dec 08:
- [x] Add contract resolution and payout
- [x] Cleanup demo script
- [x] Add basic user event-notification feature
- [ ] Working blockchain integration (rich)

Sat Dec 09
----------------------------------------------

Discussion:
- during time-warp, should we auto-resolve contracts, or do it manually?

Target Outcomes Dec 09:
- [x] Add event notification on signup
- [x] Add offer-matching page
- [x] End-to-end functioning demo script
- [ ] Working blockchain integration (rich)

Sun Dec 10
----------------------------------------------

Discussion:
- all server code is functionally complete
- today is 100% cleanup - bugfixing, wording, checking amounts, etc.
- we should do a final rehersal this eve or tomorrow am

Target Outcomes Dec 10:
- [x] Detail checking: wording, amounts, etc.
- [x] Record a new demo script
- [ ] Working blockchain integration (rich)
- [ ] Write a deployment plan

Mon Dec 11
----------------------------------------------

Target Outcomes Dec 11:
- [x] Tweak the demo script
- [ ] Make a new screencast
- [ ] Write a deployment plan
- [ ] Working blockchain integration (rich)


Mon Dec 12
----------------------------------------------

Target Outcomes Dec 11:
- [x] Finish the demo script
- [x] Make a new screencast
- [x] Write a deployment plan
- [x] Working blockchain integration (rich)