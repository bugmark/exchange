# integration_test: commands/contract_cmd/cross/reduce

require_relative '../commit'

class Commit::Reduce < Commit

  def generate
    ctx = base_context

    # look up contract
    ctx.c_contract = bundle.offer.obj.salable_position.contract
    ctx.c_uuid     = ctx.c_contract.uuid

    # generate amendment, escrow, price
    ctx.e_type = "Escrow::Reduce"
    ctx.a_type = "Amendment::Reduce"
    ctx = gen_escrow(ctx)
    ctx = gen_amendment(ctx)

    # calculate price for offer and counter
    ctx.counter_price = bundle.counters.map {|el| el.obj.price}.min
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    gen_position(bundle.offer, ctx, ctx.offer_price)  # BUG HERE - NEED TO PAYOUT ...
    bundle.counters.each {|offer| gen_position(offer, ctx, ctx.counter_price)}

    # update escrow value
    ctx = update_escrow_value(ctx)

    self
  end

  private

  # UNDER CONSTRUCTION
  def gen_position(offer, ctx, price)
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
end