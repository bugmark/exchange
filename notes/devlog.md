# Bugmark Exchange Devlog

## 20 Jun Wed

- [x] create ledger object
- [x] create paypro object

## 21 Jun Thu

- [x] schema -> stm_currency
- [x] schema -> stm_paypro_uuid
- [x] schema -> Offer#ledger_uuid

## 22 Jun Fri

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

- [ ] UserCmd::GroupCreate 

- [ ] UserCmd::GroupDelete
- [ ] Event::GroupDeleted

- [ ] UserCmd::LedgerCreate 
- [ ] Event::LedgerCreated

- [ ] UserCmd::LedgerUpdate   
- [ ] Event::LedgerUpdated

- [ ] UserCmd::LedgerClose    
- [ ] Event::LedgerClosed

- [ ] UserCmd::LedgerDeposit  
- [ ] Event::LedgerDeposited

- [ ] UserCmd::LedgerWithdraw 
- [ ] Event::LedgerWithdrawn

- [ ] UserCmd::LedgerCredit   
- [ ] Event::LedgerCredited

- [ ] UserCmd::LedgerDebit    
- [ ] Event::LedgerDebited

- [ ] UserCmd::Create should generate a default ledger

- [ ] Offer::Create should always set  `stm_currency` and `stm_paypro`
- [ ] Match - find offers in matching currency and paypro
- [ ] cross   - use ledger/debit command
- [ ] resolve - use ledger/credit command

- [ ] user.balance         -> user.ledger_balance
- [ ] user.token_reserve   -> user.ledger_reserve
- [ ] user.token_available -> user.ledger_available

