# integration_test: commands/contract_cmd/cross/expand
# integration_test: commands/contract_cmd/cross/transfer
# integration_test: commands/contract_cmd/cross/reduce

require 'ostruct'

class Commit

  attr_reader :type, :bundle, :contract, :escrow, :amendment

  TYPES = %i(expand transfer reduce)

  def initialize(bundle)
    @type   = bundle.type
    @bundle = bundle
    raise "BAD commit type (#{type})" unless TYPES.include?(type)
  end

  def generate() raise("call in subclass"); self end

  private

  def base_context
    ctx            = OpenStruct.new
    ctx.all_offers = [bundle.offer] + bundle.counters
    ctx.max_start  = ctx.all_offers.map {|o| o.obj.maturation_range.begin}.max
    ctx.min_end    = ctx.all_offers.map {|o| o.obj.maturation_range.end}.min
    ctx
  end

  def gen_connectors(ctx, amendment_klas, escrow_klas)
    ctx.amendment = amendment_klas.create(contract: ctx.contract)
    ctx.escrow    = escrow_klas.create(contract: ctx.contract, amendment: ctx.amendment)
    ctx
  end

  def expand_position(offer, ctx, price)
    posargs = {
      volume:     offer.vol         ,
      price:      price             ,
      amendment:  ctx.amendment     ,
      escrow:     ctx.escrow        ,
      offer:      offer.obj         ,
      user:       offer.obj.user    ,
    }
    lcl_pos = Position.create(posargs)
    new_balance = offer.obj.user.balance - lcl_pos.value
    offer.obj.user.update_attribute(:balance, new_balance)
    offer.obj.update_attribute(:status, 'crossed')
  end

  def suspend_overlimit_offers(bundle)
    list = [bundle.offer] + bundle.counters
    list.each do |offer|
      usr       = offer.obj.user
      threshold = usr.balance - usr.token_reserve_not_poolable
      uoffers   = usr.offers.open.poolable.where('value > ?', threshold)
      uoffers.each do |uoffer|
        OfferCmd::Suspend.new(uoffer).project
      end
    end
  end

  def generate_reoffers(ctx)
    ctx.escrow.positions.each do |position|
      if position.volume < position.offer.volume
        new_vol = position.offer.volume - position.volume
        args    = {volume: new_vol, reoffer_parent_id: position.offer.id, amendment_id: ctx.amendment.id}
        result  = OfferCmd::CloneBuy.new(position.offer, args)
        result.project
      end
    end
  end

end