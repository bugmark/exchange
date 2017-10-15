class Offer::Buy::Ask < Offer::Buy

  before_validation :default_values

  def xtag
    "ask"
  end

  def matching_bid_reserve
    @mb_reserve ||= matching_bids.reduce(0) {|acc, bid| acc + bid.reserve}
  end

  private

  def default_values
    self.type               ||= 'Ask::GitHub'
    self.status             ||= 'open'
    self.price              ||= 0.10
    self.volume             ||= 1
    self.maturation_period  ||= Time.now+1.minute..Time.now+1.week
  end
end