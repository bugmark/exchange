# Bugmark Exchange Devlog

## 20 Jun WED

- [x] create ledger object
- [x] create paypro object

## 21 Jun THU

- [x] schema -> stm_currency
- [x] schema -> stm_paypro_uuid
- [x] schema -> Offer#ledger_uuid

## 22 Jun FRI

- [x] UserGroup spec
- [x] UserLedger spec
- [x] Paypro spec
- [x] PayproCmd::Create  
- [x] Event::PayproCreated 
- [x] Create :paypro factory
- [x] Create spec for :paypro factory
- [x] PayproCmd::Update 
- [x] Event::PayproUpdated
- [x] PayproCmd::Close  
- [x] Event::PayproClosed
- [x] BugmHost::Reset should create a YAML paypro
- [x] Event::GroupCreated

## 23 Jun SAT

- [x] UserCmd::GroupCreate 

## 24 Jun SUN

- [x] Event::UserGroupOpened
- [x] UserCmd::GroupOpen
- [x] Factory :user_group
- [x] Event::UserGroupClosed
- [x] UserCmd::GroupClose

## 25 Jun MON

- [x] Event::UserMembershipOpened
- [x] UserCmd::MembershipOpen
- [x] Factory :user_membership
- [x] Event::UserMembershipClosed
- [x] UserCmd::MembershipClose
- [x] Event::UserLedgerOpened
- [x] UserCmd::LedgerOpen
- [x] Factory :user_ledger
- [x] Event::UserLedgerClosed
- [x] UserCmd::LedgerClose
- [x] Event::UserLedgerDeposited
- [x] UserCmd::LedgerDeposit  
- [x] Event::UserLedgerWithdrawn
- [x] UserCmd::LedgerWithdraw 
- [x] Event::UserLedgerDebited
- [x] UserCmd::LedgerDebit    
- [x] Event::UserLedgerCredited
- [x] UserCmd::LedgerCredit   
- [x] UserCmd::LedgerTransfer(src, tgt) 
- [x] UserCmd::Create should generate a default ledger

## 26 Jun TUE

- [x] Finish Paypro design

## 17 Jul TUE

- [x] Install GraphQL
- [x] Working Graphiql

- [ ] Require IORA/GitHub to use GraphQL interface

- [ ] GraphQL queries
- [ ] GraphQL mutations

## TBD

- [ ] Remove writes to InfluxDB
- [ ] Add writes to NATS

- [ ] Remove Restful Layer
- [ ] Extract demo applications

- [ ] Rewrite CLI to use GraphQL
- [ ] Rewrite CLI to use TTY Gems

- [ ] Rewrite Intern exercise to use GraphQL
- [ ] Get all TestBench exercises working via GraphQL

- [ ] Dockerize the Exchange
- [ ] Dockerize PostgresQL
- [ ] Dockerize Nats

- [ ] test j/x fields: trackers
- [ ] test j/x fields: issues
- [ ] test j/x fields: offers
- [ ] test j/x fields: contracts
- [ ] test j/x fields: amendments
- [ ] test j/x stm fields: issues
- [ ] test j/x stm fields: offers
- [ ] test j/x stm fields: contracts

- [ ] Offer::Create should always set  `stm_currency` and `stm_paypro`
- [ ] Match - find offers in matching currency and paypro
- [ ] cross   - use ledger/debit command
- [ ] resolve - use ledger/credit command

- [ ] user.balance         -> user.ledger_balance
- [ ] user.token_reserve   -> user.ledger_reserve
- [ ] user.token_available -> user.ledger_available

