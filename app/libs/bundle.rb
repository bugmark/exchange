module Bundle
  def self.init(type, offer, counters)
    klas = case type
      when :expand  then Bundle::Expand
      when :realloc then Bundle::Realloc
      when :reduce  then Bundle::Reduce
      else rase "Unrecognized type #{type}"
    end
    klas.new(offer, counters)
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
      offer: [offer, pool_volume]    ,
      counter: pool_offers
    }
  end
end