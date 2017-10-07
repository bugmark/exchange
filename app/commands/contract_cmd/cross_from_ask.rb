module ContractCmd
  class CrossFromAsk < ApplicationCommand

    attr_subobjects :contract, :ask
    attr_reader     :cross_list
    attr_delegate_fields :contract

    validate :cross_integrity

    def initialize(ask_param, contract_opts = {})
      @ask        = Ask.where(contract_id: nil).find(ask_param.to_i)
      @contract   = Contract.new(contract_opts)
      @cross_list = gen_cross(ask)
    end

    def transact_before_project
      contract.save
      ask.contract_id = contract.id
      cross_list.each { |bid| bid.update_attributes(contract_id: contract.id) }
    end

    private

    def gen_cross(ask)
      return [] unless ask.present?
      bid = ask.matching_bids.find {|bid| bid.reserve == ask.complementary_reserve}
      if bid
        contract.assign_attributes(ask.cross_attrs)
        contract.price  = ask.price
        contract.volume = ask.volume
        [bid]
      else
        []
      end
    end

    def cross_integrity
      # TODO: check balances on both sides of the cross to ensure they are valid
      if @cross_list.length == 0
        errors.add :id, "no crosses found"
      end
      if @ask.nil?
        errors.add :id, "invalid ask"
      end
    end
  end
end
