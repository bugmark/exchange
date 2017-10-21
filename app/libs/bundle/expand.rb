module Bundle
  class Expand

    attr_reader :type, :offer, :counters

    def initialize(type, offer, counters)
      @type = type
      @offer = offer
      @counters = counters
    end

    def generate
      "TBD"
    end
  end
end
