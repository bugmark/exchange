require 'ostruct'

class Bundle

  attr_reader :type, :offer, :counters

  def initialize(type, offer, counters)
    @type     = type
    @offer    = offer
    @counters = counters
  end

  def generate
    counter_aon  = counters.where(aon: true)
    counter_alt  = counters.where(aon: false)
    pool_offers = []
    pool_volume  = 0

    counter_aon.each do |offer|
      if offer.volume <= source.volume = pool_volume
        pool_offers << [offer, offer.volume]
        pool_volume += offer.volume
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
end