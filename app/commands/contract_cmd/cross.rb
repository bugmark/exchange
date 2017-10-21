module ContractCmd
  class Cross < ApplicationCommand

    attr_subobjects :offer, :counters, :commit_type
    attr_delegate_fields :src_offer

    validate :cross_integrity

    def initialize(offer, commit_type)
      @commit_type = commit_type
      @offer       = Offer.find(offer.to_i)
      @counters    = @offer.qualified_counteroffers(commit_type)
    end

    def transact_before_project
      bundle = Bundle.init(commit_type, offer, counters).generate
      _result = Commit.init(commit_type, bundle).generate
    end

    private

    def cross_integrity
      if offer.nil?
        errors.add :base, "no offer found"
      end

      unless %i(expand realloc reduce).include?(commit_type)
        errors.add :base, "invalid commit type (#{commit_type})"
      end

      if counters.nil? || counters.blank?
        errors.add :id, "no qualified counteroffers found"
      end

      if offer.aon? && offer.volume > counters.pluck(:volume).sum
        errors.add :id, "not enough counteroffer volume (AON)"
      end
    end
  end
end
