require 'ostruct'

class Bundle

  attr_reader :type, :offer, :counters

  def initialize(type, offer, counters)
    @type     = type
    @offer    = offer
    @counters = counters
  end

  def generate
    max_counters = longest_overlap_union(counters)
    counter_aon  = max_counters.where(aon: true)
    counter_alt  = max_counters.where(aon: false)
    pool_offers = []
    pool_volume  = 0

    counter_aon.each do |counter_offer|
      if (offer.volume - pool_volume) >= counter_offer.volume
        pool_offers << OpenStruct.new(obj: counter_offer, vol: counter_offer.volume)
        pool_volume += counter_offer.volume
      end
    end

    counter_alt.each do |counter_offer|
      headroom = @offer.volume - pool_volume
      if headroom > 0
        tmp = [headroom, counter_offer.volume].min
        pool_offers << OpenStruct.new(obj: counter_offer, vol: tmp)
        pool_volume += tmp
      end
    end

    OpenStruct.new({
      type:     type                    ,
      offer:    OpenStruct.new(vol: pool_volume, obj: offer) ,
      counters: pool_offers
    })
  end

  private

  def longest_overlap_union(counters)
    return counters if counters.length == 1
    counters.pluck(:maturation_range).reduce([]) do |acc, range|
      list = counters.by_range(range)
      list.length > acc.length ? list : acc
    end
  end
end