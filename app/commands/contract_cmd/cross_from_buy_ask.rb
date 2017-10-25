module ContractCmd
  class CrossFromBuyAsk < ApplicationCommand

    # attr_subobjects :contract, :ask, :escrow, :bid
    # attr_delegate_fields :contract
    #
    # validate :cross_integrity
    #
    # def initialize(ask_param, contract_opts = {})
    #   @ask      = Offer::Buy::Ask.unassigned.find(ask_param.to_i)
    #   @contract = @ask.match_contracts.first || Contract.new(contract_opts)
    #   @escrow   = Escrow.new
    #   @bid      = gen_cross(ask).first
    # end
    #
    # def transact_before_project
    #   # TODO: pick best-fit maturation date
    #   contract.assign_attributes(ask.match_attrs)
    #   contract.maturation = ask.maturation
    #   contract.save
    #   escrow.assign_attributes(contract: contract, bid_value: bid.value, ask_value: ask.value)
    #   escrow.save
    #   # TODO: pick best-fit price
    #   Position.create(volume: bid.volume, price: bid.price, user: bid.user, offer: bid, escrow: escrow, side: 'bid')
    #   Position.create(volume: ask.volume, price: ask.price, user: ask.user, offer: ask, escrow: escrow, side: 'ask')
    #   bid.update_attribute :status, 'crossed'
    #   ask.update_attribute :status, 'crossed'
    #   bid.user.decrement(bid.value).save
    #   ask.user.decrement(bid.value).save
    # end
    #
    # private
    #
    # def gen_cross(ask)
    #   # TODO: enable partial crosses, multi-party crosses
    #   return [] unless ask.present?
    #   bids = ask.qualified_counteroffers(:expand)
    #   unless bids.empty?
    #     bid = bids.first
    #     [bid]
    #   else
    #     []
    #   end
    # end
    #
    # def cross_integrity
    #   if @bid.nil?
    #     errors.add :id, "no crosses found"
    #   end
    #   if @ask.nil?
    #     errors.add :id, "invalid ask"
    #   end
    # end
  end
end
