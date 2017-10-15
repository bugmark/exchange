class Offer::Buy::Bid < Offer::Buy

  before_validation :default_values

  def xtag
    "bid"
  end

  private

  def default_values
    self.type              ||= 'Bid::GitHub'
    self.status            ||= 'open'
    self.price             ||= 0.10
    self.maturation_period ||= Time.now+1.minute..Time.now+1.week
  end

end