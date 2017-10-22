require 'ext/array'  # for allsums method...

module ContractCmd
  class Cross < ApplicationCommand

    attr_subobjects :offer, :counters, :commit_type
    attr_reader :commit_type
    # attr_delegate_fields :src_offer

    validate :cross_integrity
    validate :compatible_volumes

    def initialize(offer, commit_type)
      @commit_type = commit_type
      @offer       = Offer.find(offer.to_i)
      @counters    = @offer.qualified_counteroffers(commit_type)
    end

    def transact_before_project
      bundle  = Bundle.new(commit_type, offer, counters).generate
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
    end

    def compatible_volumes

      if offer.aon? && offer.volume > counters.pluck(:volume).sum
        errors.add :base, "Err1: not enough counteroffer volume (AON)"
      end

      counter_pool = counters.where(aon: false).pluck(volume).sum
      counter_aon  = counters.where(aon: true).pluck(volume)
      allsums      = counter_aon.allsums

      if offer.aon? && ! allsums.include?(([0, offer.volume - counter_pool].max))
        errors.add :base, "Err2: no volume match"
      end

      if counter_pool == 0 && allsums[1..-1].min > offer.volme
        errors.add :base, "Err3: no volume match (counteroffer AON)"
      end
    end
  end
end
