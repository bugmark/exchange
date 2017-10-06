class ApplicationOffer < ApplicationRecord
  self.abstract_class = true

  # common methods for bids and asks

  def reserve
    self.volume * self.price
  end

  def complementary_reserve
    self.volume - reserve
  end

  def matching_bugs
    @bugmatch ||= Bug.match(match_attrs)
  end

  def matching_bids
    @bidmatch ||= Bid.match(cross_attrs)
  end
end