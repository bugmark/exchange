# integration_test: commands/contract_cmd/cross/expand
# integration_test commands/contract_cmd/cross/transfer
# integration_test commands/contract_cmd/cross/reduce

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

  def ctx_event(name, klas, params)
    @events << OpenStruct.new(name: name.to_sym, klas: klas, params: params)
  end

  # notation:
  # ctx.o_* - offer variables
  # ctx.c_* - contract variables
  # ctx.a_* - amendment variables
  # ctx.e_* - escrow variables
  def base_context
    ctx            = OpenStruct.new
    ctx.o_all      = [bundle.offer] + bundle.counters
    ctx.o_max_beg  = ctx.o_all.map {|o| o.obj.maturation_range.begin}.max
    ctx.o_min_end  = ctx.o_all.map {|o| o.obj.maturation_range.end}.min
    ctx
  end

  def find_or_gen_contract(ctx, _amendment_type = "", _escrow_type = "")
    ctx.c_matching = bundle.offer.obj.match_contracts.overlap(ctx.o_max_beg, ctx.o_min_end)
    ctx.c_selected = ctx.c_matching.sort_by {|c| c.escrows.count}.first
    ctx.c_uuid     = ctx.c_selected&.uuid || SecureRandom.uuid
    ctx.c_contract = @contract = ctx.c_selected || begin
      date = [ctx.o_max_beg, ctx.o_min_end].avg_time #
      attr = bundle.offer.obj.match_attrs.merge(maturation: date, uuid: ctx.c_uuid)
      ctx_event(:contract, Event::ContractCreated, attr)
    end
    ctx
  end

  def gen_escrow_and_amendment(ctx, _wat = "", _nog = "")
    ctx.a_uuid = SecureRandom.uuid
    ctx_event(:amendment, Event::AmendmentCreated, contract_uuid: ctx.c_uuid, uuid: ctx.a_uuid)
    ctx.e_uuid = SecureRandom.uuid
    ctx_event(:escrow, Event::EscrowCreated, contract_uuid: ctx.c_uuid, amendment_uuid: ctx.a_uuid, uuid: ctx.e_uuid)
    ctx
  end

  def update_escrow_value(ctx)
    ctx_event(:escrow_upd, Event::EscrowUpdated, {uuid: ctx.e_uuid})
    ctx
  end

  def expand_position(offer, ctx, price)
    transfer_uuid = SecureRandom.uuid
    posargs = {
      uuid:           SecureRandom.uuid      ,
      volume:         offer.vol.to_i         ,
      price:          price.to_f             ,
      side:           offer.obj.side         ,
      amendment_uuid: ctx.a_uuid             ,
      escrow_uuid:    ctx.e_uuid             ,
      offer_uuid:     offer.obj.uuid         ,
      user_uuid:      offer.obj.user.uuid    ,
      transfer_uuid:  transfer_uuid
    }
    oid = offer.obj.id
    ctx_event("position#{oid}", Event::PositionCreated, posargs)
    lcl_val = posargs[:volume] * posargs[:price]
    ctx_event("user#{oid}" , Event::UserDebited, {uuid: offer.obj.user_uuid, amount: lcl_val})
    ctx_event("offer#{oid}", Event::OfferCrossed, {uuid: offer.obj.uuid})
  end

  def suspend_overlimit_offers(bundle, ctx)
    list = [bundle.offer] + bundle.counters
    list.each do |offer|
      usr       = offer.obj.user
      threshold = usr.balance - offer.obj.value - usr.token_reserve_not_poolable
      uoffers   = usr.offers.open.poolable.where('value > ?', threshold)
      uoffers.each do |uoffer|
        ctx_event("offer_suspend#{uoffer.id}", Event::OfferSuspended, {uuid: uoffer.uuid})
      end
    end
  end

  def generate_reoffers(ctx)
    idx = 0
    position_events.each do |position|
      volume = position.params[:volume]
      offer  = Offer.find_by_uuid(position.params[:offer_uuid])
      if volume < offer.volume
        idx += 1
        new_vol = offer.volume - volume
        args    = {uuid: SecureRandom.uuid, volume: new_vol, prototype_uuid: offer.uuid, amendment_uuid: ctx.a_uuid}
        ctx_event("reoffer#{idx}", Event::OfferCloned, args)
      end
    end
  end

  def position_events
    @events.select {|ev| ev.klas == Event::PositionCreated}
  end
end
