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

## 18 Jul WED

- [x] GraphQL queries
- [x] GraphQL mutations
- [x] Start rewrite CLI to use GraphQL
- [x] CLI: host
- [x] GraphQL Query: host
- [x] CLI: user
- [x] GraphQL Query: user

## 19 Jul THU

- [x] Add http-basic auth to /graphql controller
- [x] Configure graphiql to generate http basic header
- [x] Set a 'current_user' context in the GraphQL server
- [x] Configure CLI to generate http basic header

## 12 Sep WED

- [x] add gRPC gems
- [x] create helloworld.proto
- [x] build simple proof-of-concept
- [x] Remove writes to InfluxDB

## 17 Sep MON

- [x] Add a grpc-ruby repo & rubygem
- [x] validate gRPC interceptors

## 18 Sep TUE

- [x[ gRPC fail - drop it

## 19 Sep WED

- [x] add GraphQL encryption with TLS
- [x] add GraphQL basic-auth 

## 20 Sep THU

- [x] GraphQL Query: tracker

## 21 Sep FRI

- [x] GraphQL Query: issue
- [x] GraphQL Query: offer
- [x] GraphQL Query: contract
- [x] GraphQL Query: position
- [x] GraphQL Query: escrow
- [x] GraphQL Query: event
- [x] GraphQL Query: amendment

## 21 Nov WED

- [x] Document Queries

## 27 Nov TUE

- [x] GraphQL Command: userCreate
- [x] GraphQL Command: userDeposit
- [x] GraphQL Command: userWithdraw

## 14 Jan MON

- [x] GraphQL User Specs

- [ ] spec: userCreate
- [ ] spec: userDeposit
- [ ] spec: userWithdraw

- [ ] GraphQL Command: offerCreateBuy
- [ ] GraphQL Command: offerCancel
- [ ] GraphQL Command: offerCreateClone
- [ ] GraphQL Command: offerCreateCounter
- [ ] GraphQL Command: offerCreateSell
- [ ] GraphQL Command: offerExpire
- [ ] GraphQL Command: offerSuspend

- [ ] GraphQL Command: trackerCreate
- [ ] GraphQL Command: trackerGhCreate
- [ ] GraphQL Command: trackerGhSync

- [ ] GraphQL Command: contractCancel
- [ ] GraphQL Command: contractClone
- [ ] GraphQL Command: contractCreate
- [ ] GraphQL Command: contractCross
- [ ] GraphQL Command: contractResolve

- [ ] GraphQL Command: issueSync

- [ ] GraphQL Command: payproClose
- [ ] GraphQL Command: payproCreate
- [ ] GraphQL Command: payproUpdate

- [ ] GraphQL Command: userGroupClose
- [ ] GraphQL Command: userGroupOpen
- [ ] GraphQL Command: userLedgerClose
- [ ] GraphQL Command: userLedgerOpen
- [ ] GraphQL Command: userLedgerTransfer
- [ ] GraphQL Command: userLedgerWithdraw
- [ ] GraphQL Command: userMembershipClose
- [ ] GraphQL Command: userMembershipOpen

## TBD

- [ ] Rewrite the CLI to use GraphQL

- [ ] Rewrite Intern exercise to use GraphQL
- [ ] Get all TestBench exercises working via GraphQL
- [ ] Extract demo application and rewrite to use GraphQL

- [ ] Get rid of Bugmark language bindings
- [ ] Remove Restful Layer

- [ ] Write event-stream to NATS
- [ ] Write event-stream to Logfile

- [ ] Containerize the Exchange
- [ ] Containerize PostgresQL
- [ ] Containerize Nats

- [ ] Rewrite IORA to use GraphQL interface
- [ ] Rewrite PayPro to use GraphQL interface

- [ ] configure Liftbridge with TLS
- [ ] configure NATS with TLS

- [ ] Rewrite CLI to use TTY Gems

- [ ] Offer::Create should always set  `stm_currency` and `stm_paypro`
- [ ] Match - find offers in matching currency and paypro
- [ ] cross   - use ledger/debit command
- [ ] resolve - use ledger/credit command

- [ ] user.balance         -> user.ledger_balance
- [ ] user.token_reserve   -> user.ledger_reserve
- [ ] user.token_available -> user.ledger_available

- [ ] add striim/digitalcurrency paypro
