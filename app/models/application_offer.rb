class ApplicationOffer < ApplicationRecord
  self.abstract_class = true

  # common methods for bids and asks

  validates :status, inclusion: {in: %w(open matured resolved)}
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

  def reserve
    self.volume * self.price
  end

  def attach_type
    self.bug_id ? "bugs" : "repos"
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

  def contract_maturation_str
    self.maturation_date.strftime("%b-%d %H:%M:%S")
  end

  def maturation_date=(date)
    self.maturation_period = date-2.days..date
  end

  def maturation_date
    maturation_period.end
  end

  def matured?
    self.maturation_date < Time.now
  end

  def unmatured?
    ! matured?
  end
end