# integration_test: commands/contract_cmd/cross/expand
# integration_test: commands/contract_cmd/cross/transfer
# integration_test: commands/contract_cmd/cross/reduce

require 'ostruct'

class Commit

  attr_reader :type, :bundle, :contract, :escrow, :amendment

  attr_reader :events

  def initialize(bundle)
    @bundle = bundle
    @events = []
  end

  def generate() raise("call in subclass") end

  private

  def add_ctx_event(name, klas, params)
    @events << OpenStruct.new(name: name, klas: klas, params: params)
  end

  # notation:
  # ctx.o_* - offer variables
  # ctx.c_* - contract variables
  # ctx.a_* - amendment variables
  # ctx.e_* - escrow variables
  def base_context
    ctx              = OpenStruct.new
    ctx.o_all        = [bundle.offer] + bundle.counters
    ctx.o_max_start  = ctx.o_all.map {|o| o.obj.maturation_range.begin}.max
    ctx.o_min_end    = ctx.o_all.map {|o| o.obj.maturation_range.end}.min
    ctx
  end

  def find_or_gen_contract(ctx)
    ctx.c_matching = bundle.offer.obj.match_contracts.overlap(ctx.o_max_start, ctx.o_min_end)
    ctx.c_selected = ctx.c_matching.sort_by {|c| c.escrows.count}.first
    ctx.c_contract = @contract = ctx.c_selected || begin
      date = [ctx.o_max_start, ctx.o_min_end].avg_time
      attr = bundle.offer.obj.match_attrs.merge(maturation: date)
      # WRITE | add_ctx_event(:contract, Event::ContractCreated, attr)
      Contract.create(attr)
    end
    ctx
  end

  def gen_escrow_and_amendment(ctx, amendment_klas, escrow_klas)
    # WRITE | add_ctx_event(:amendment, Event::AmendmentCreated, amend_attr)
    ctx.a_amendment = amendment_klas.create(contract: ctx.c_contract)
    # WRITE | add_ctx_event(:escrow, Event::EscrowCreated, escrow_attr)
    ctx.e_escrow    = escrow_klas.create(contract: ctx.c_contract, amendment: ctx.a_amendment)
    ctx
  end

  def update_escrow_value(ctx)
    # WRITE | add_ctx_event(:escrow_upd, Event::EscrowUpdated, attr)
    attr = {
      fixed_value: ctx.e_escrow.fixed_values,
      unfixed_value: ctx.e_escrow.unfixed_values
    }
    ctx.e_escrow.update_attributes(attr)
    ctx
  end

  def expand_position(offer, ctx, price)
    posargs = {
      volume:     offer.vol         ,
      price:      price             ,
      amendment:  ctx.a_amendment   ,
      escrow:     ctx.e_escrow      ,
      offer:      offer.obj         ,
      user:       offer.obj.user    ,
    }
    # WRITE | add_ctx_event(:posX, Event::PositionCreate, posargs)
    lcl_pos = Position.create(posargs)
    new_balance = offer.obj.user.balance - lcl_pos.value
    # WRITE | add_ctx_event(:usr1, Event::UserBalanceUpdated, TBD)
    offer.obj.user.update_attribute(:balance, new_balance)
    # WRITE | add_ctx_event(:offer, Event::OfferUpdate, status: 'crossed')
    offer.obj.update_attribute(:status, 'crossed')
  end

  def suspend_overlimit_offers(bundle)
    list = [bundle.offer] + bundle.counters
    list.each do |offer|
      usr       = offer.obj.user
      threshold = usr.balance - usr.token_reserve_not_poolable
      uoffers   = usr.offers.open.poolable.where('value > ?', threshold)
      uoffers.each do |uoffer|
        # WRITE | add_ctx_event(:offer_suspend, Event::OfferSuspend, ASDF)
        OfferCmd::Suspend.new(uoffer).project
      end
    end
  end

  def generate_reoffers(ctx)
    ctx.e_escrow.positions.each do |position|
      if position.volume < position.offer.volume
        new_vol = position.offer.volume - position.volume
        args    = {volume: new_vol, reoffer_parent_id: position.offer.id, amendment_id: ctx.a_amendment.id}
        # WRITE | add_ctx_event(:offer_clone, Event::OfferCloned, QWER)
        result  = OfferCmd::CloneBuy.new(position.offer, args)
        result.project
      end
    end
  end
end
