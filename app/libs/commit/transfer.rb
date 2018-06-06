# integration_test: commands/contract_cmd/cross/transfer

require_relative '../commit'

class Commit::Transfer < Commit

  def generate
    ctx = base_context

    # look up contract
    ctx.c_contract = bundle.offer.obj.salable_position.contract ||
                     bundle.offer.obj.position.contract
    ctx.c_uuid     = ctx.c_contract.uuid
    @contract      = ctx.c_contract

    # generate amendment (but not escrow)
    ctx.a_type = "Amendment::Transfer"
    ctx = gen_amendment(ctx)

    # calculate price for offer and counters
    clist             = bundle.counters.map {|el| el.obj.price}
    cprice            = bundle.offer.obj.is_sell? ? clist.max : clist.min
    oprice            = bundle.offer.obj.price
    ctx.counter_price = [oprice, cprice].avg.round(2)
    ctx.offer_price   = ctx.counter_price

    # generate artifacts
    gen_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| gen_position(offer, ctx, ctx.counter_price)}

    # return self
    self
  end

  private

  def gen_position(offer, ctx, price)
    transfer_uuid = SecureRandom.uuid
    posargs = {
      uuid:           SecureRandom.uuid      ,
      volume:         offer.vol.to_i         ,
      price:          1 - price.to_f         ,
      side:           offer.obj.side         ,
      offer_uuid:     offer.obj.uuid         ,
      user_uuid:      offer.obj.user.uuid    ,
      amendment_uuid: ctx.a_uuid             ,
      escrow_uuid:    ctx.e_uuid             ,
      parent_uuid:    offer.salable_position_uuid,
      transfer_uuid:  transfer_uuid
    }
    offer
    oid = offer.obj.id
    ctx_event("position#{oid}", Event::PositionCreated, posargs)
    lcl_val = posargs[:volume] * posargs[:price]
    ctx_event("offer#{oid}", Event::OfferCrossed, {uuid: offer.obj.uuid})
    if offer.obj.is_sell?
      ctx_event("user#{oid}" , Event::UserCredited, {uuid: offer.obj.user_uuid, amount: lcl_val})
    else
      ctx_event("user#{oid}" , Event::UserDebited, {uuid: offer.obj.user_uuid, amount: lcl_val})
    end
  end
end