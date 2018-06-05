# integration_test: commands/contract_cmd/cross/expand

require_relative '../commit'

class Commit::Expand < Commit
  def generate
    ctx = base_context

    # find or generate contract with maturation date
    ctx = find_or_gen_contract(ctx)

    # generate amendment and escrow
    ctx.e_type = "Escrow::Expand"
    ctx.a_type = "Amendment::Expand"
    ctx = gen_escrow_and_amendment(ctx)

    # calculate price for offer and counter - half-way between the two
    ctx.counter_min   = bundle.counters.map {|el| el.obj.price}.min
    ctx.price_delta   = ((bundle.offer.obj.price - (1.0 - ctx.counter_min)) / 2.0).round(2)
    ctx.counter_price = ctx.counter_min - ctx.price_delta
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    gen_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| gen_position(offer, ctx, ctx.counter_price)}
    suspend_overlimit_offers(bundle, ctx)
    generate_reoffers(ctx)

    # update escrow value
    ctx = update_escrow_value(ctx)

    # return self
    self
  end

  private

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