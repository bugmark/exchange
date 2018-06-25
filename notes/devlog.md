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

- [ ] UserCmd::MembershipOpen
- [ ] Factory :user_membership

- [ ] Event::UserMembershipClosed
- [ ] UserCmd::MembershipClose

- [ ] Event::UserLedgerOpened
- [ ] UserCmd::LedgerOpen
- [ ] Factory :user_ledger

- [ ] Event::UserLedgerClosed
- [ ] UserCmd::LedgerClose

- [ ] Event::UserLedgerUpdated
- [ ] UserCmd::LedgerUpdate   

- [ ] Event::UserLedgerDeposited
- [ ] UserCmd::LedgerDeposit  

- [ ] Event::UserLedgerWithdrawn
- [ ] UserCmd::LedgerWithdraw 

- [ ] Event::UserLedgerCredited
- [ ] UserCmd::LedgerCredit   

- [ ] Event::UserLedgerDebited
- [ ] UserCmd::LedgerDebit    

- [ ] UserCmd::LedgerTransfer(src, tgt) 
- [ ] UserCmd::Create should generate a default ledger

- [ ] Offer::Create should always set  `stm_currency` and `stm_paypro`
- [ ] Match - find offers in matching currency and paypro
- [ ] cross   - use ledger/debit command
- [ ] resolve - use ledger/credit command

- [ ] user.balance         -> user.ledger_balance
- [ ] user.token_reserve   -> user.ledger_reserve
- [ ] user.token_available -> user.ledger_available

