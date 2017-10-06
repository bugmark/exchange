class ApplicationOffer < ApplicationRecord
  self.abstract_class = true

  # common methods for bids and asks

  validates :status, inclusion: {in: %w(open matured resolved)}
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

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