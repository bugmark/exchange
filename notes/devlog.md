# Bugmark Exchange Devlog

## 20 Jun Wed

- [x] create ledger object
- [x] create paypro object

## 21 Jun Thu

- [x] schema -> stm_currency
- [x] schema -> stm_paypro_uuid
- [x] schema -> Offer#ledger_uuid

## 22 Jun Fri

- [ ] PayproCmd::Create | Event::PayproCreated
- [ ] PayproCmd::Update | Event::PayproUpdated
- [ ] PayproCmd::Close  | Event::PayproClosed

- [ ] BugmHost::Reset should create a YAML paypro
- [ ] UserCmd::Create should generate a default ledger
- [ ] Offer::Create should always set  `stm_currency` and `stm_paypro`
- [ ] Match - find offers in matching currency and paypro
- [ ] cross   - use ledger/debit command
- [ ] resolve - use ledger/credit command

- [ ] user.balance         -> user.ledger_balance
- [ ] user.token_reserve   -> user.ledger_reserve
- [ ] user.token_available -> user.ledger_available

- [ ] UserCmd::LedgerCreate   
- [ ] UserCmd::LedgerUpdate
- [ ] UserCmd::LedgerClose
- [ ] UserCmd::LedgerDeposit
- [ ] UserCmd::LedgerWithdraw
- [ ] UserCmd::LedgerCredit
- [ ] UserCmd::LedgerDebit
