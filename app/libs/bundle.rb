module Bundle
  def self.init(type, offer, counters)
    klas = case type
      when :expand then Bundle::Expand
      when :realloc then Bundle::Realloc
      when :reduce then Bundle::Reduce
      else rase "Unrecognized type #{type}"
    end
    klas.new(type, offer, counters)
  end
end