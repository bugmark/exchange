# integration_test:  commands/contract_cmd/cross/expand
# integration_test   commands/contract_cmd/cross/transfer
# integration_test   commands/contract_cmd/cross/reduce

require 'ext/array'

module ContractCmd
  class Cross < ApplicationCommand

    attr_reader     :offer, :counters, :type, :bundle, :commit

    validate :cross_integrity

    def initialize(offer, commit_type)
      @type     = commit_type
      @offer    = Offer.find(offer.to_i)
      @counters = @offer.qualified_counteroffers(commit_type)
      if valid?
        @bundle = Bundle.new(type, offer, counters).generate
        @commit = commit_class.new(bundle).generate
        @commit.events.each do |ev|
          add_event(ev.name, ev.klas.new(cmd_opts.merge(ev.params)))
        end
      end
    end

    def contract
      commit&.contract
    end

    private

    def sort_target(counters, target)
      return counters if target.nil?
      return counters if counters.select {|el| el.uuid == target.uuid}.nil?
      [target] +  counters.select {|el| el.uuid != target.uuid}
    end

    def commit_class
      require "commit/#{type.to_s}"
      "Commit::#{type.capitalize}".constantize
    end

    def cross_integrity
      if offer.nil?
        errors.add :base, "no offer found"
        return false
      end

      unless %i(expand transfer reduce).include?(type)
        errors.add :base, "invalid commit type (#{type})"
        return false
      end

      if counters.nil? || counters.blank?
        errors.add :base, "no qualified counteroffers found"
        return false
      end

      # ----- compatible volumes -----

      if offer.aon? && offer.volume > counters.pluck(:volume).sum
        errors.add :base, "Err1: not enough counteroffer volume (AON)"
        return false
      end

      counter_pool = counters.where(aon: false).pluck(:volume).sum
      counter_aon  = counters.where(aon: true).pluck(:volume)
      allsums      = counter_aon.allsums

      if offer.aon? && ! allsums.include?(([0, offer.volume - counter_pool].max))
        errors.add :base, "Err2: no volume match"
        return false
      end
    end
  end
end
