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

- [ ] add gRPC basic-auth using interceptors

- [ ] gRPC Query: tracker
- [ ] gRPC Query: issue
- [ ] gRPC Query: offer
- [ ] gRPC Query: contract
- [ ] gRPC Query: position
- [ ] gRPC Query: escrow
- [ ] gRPC Query: event

- [ ] gRPC Command: host
- [ ] gRPC Command: user
- [ ] gRPC Command: issue
- [ ] gRPC Command: offer
- [ ] gRPC Command: contract
- [ ] gRPC Command: position
- [ ] gRPC Command: escrow
- [ ] gRPC Command: event

## TBD

- [ ] configure Liftbridge with TLS
- [ ] configure NATS with TLS
- [ ] add gRPC encryption with TLS

- [ ] Write event-stream to NATS
- [ ] Write event-stream to Logfile

- [ ] Rewrite the CLI to use gRPC
- [ ] Rewrite CLI to use TTY Gems

- [ ] Get rid of Bugmark language bindings
- [ ] Remove Restful Layer

- [ ] Rewrite Intern exercise to use gRPC
- [ ] Get all TestBench exercises working via gRPC
- [ ] Extract demo application and rewrite to use gRPC

- [ ] Containerize the Exchange
- [ ] Containerize PostgresQL
- [ ] Containerize Nats

- [ ] Rewrite IORA to use gRPC interface
- [ ] Rewrite PayPro to use gRPC interface

- [ ] Offer::Create should always set  `stm_currency` and `stm_paypro`
- [ ] Match - find offers in matching currency and paypro
- [ ] cross   - use ledger/debit command
- [ ] resolve - use ledger/credit command

- [ ] user.balance         -> user.ledger_balance
- [ ] user.token_reserve   -> user.ledger_reserve
- [ ] user.token_available -> user.ledger_available

- [ ] add striim/digitalcurrency paypro
