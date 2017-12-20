# integration_test: commands/contract_cmd/cross/expand

require_relative '../commit'

class Commit::Expand < Commit
  def generate
    ctx = base_context

    # find or generate contract with maturation date
    ctx = find_or_gen_contract(ctx)

    # generate amendment and escrow
    ctx = gen_escrow_and_amendment(ctx, Amendment::Expand, Escrow::Expand)

    # calculate price for offer and counter - half-way between the two
    ctx.counter_min   = bundle.counters.map {|el| el.obj.price}.min
    ctx.price_delta   = ((bundle.offer.obj.price - (1.0 - ctx.counter_min)) / 2.0).round(2)
    ctx.counter_price = ctx.counter_min - ctx.price_delta
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}
    suspend_overlimit_offers(bundle)
    generate_reoffers(ctx)

    # update escrow value
    ctx = update_escrow_value(ctx)

    # return self
    self
  end
end