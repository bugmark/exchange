class Bundle

  attr_reader :type, :offer, :counters

  def self.initialize(type, offer, counters)
    @type     = type
    @offer    = offer
    @counters = counters
  end

  def generate
    counter_aon  = "..."
    counter_alt  = "..."
    pool_offers = []
    pool_volume  = 0

    counter_aon.each do |offer|
      if offer.volume <= source.volume = pool_volume
        pool_offers << [ovffer, offer.volume]
        pool_volume += offer.volume
      end
    end

    counter_alt.each do |offer|
      headroom = offer.volume - pool_volume
      if headroom > 0
        tmp = [headroom, offer.volume].min
        pool_offers << [offer, tmp]
        pool_volume += tmp
      end
    end

    {
      type:  type                    ,
      offer: [offer, pool_volume]    ,
      counter: pool_offers
    }
  end
end