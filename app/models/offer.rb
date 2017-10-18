class Offer < ApplicationRecord

  include MatchUtils

  has_paper_trail

  belongs_to :user
  belongs_to :bug,      optional: true  , foreign_key: "stm_bug_id"
  belongs_to :repo,     optional: true  , foreign_key: "stm_repo_id"
  belongs_to :position, optional: true

  validates :status, inclusion: {in: %w(open suspended crossed expired cancelled)}
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

  before_validation :default_values

  # ----- BASIC SCOPES -----
  class << self
    def poolable()             where(poolable: true)      end
    def not_poolable()         where(poolable: false)     end
    def with_status(status)    where(status: status)      end
    def without_status(status) where.not(status: status)  end

    def open()     with_status('open')    end
    def not_open() without_status('open') end

    def assigned
      where("id IN (SELECT offer_id FROM positions)")
    end

    def unassigned
      where("id NOT IN (SELECT offer_id FROM positions)")
    end

    def by_maturation_period(range)
      where("maturation_period && tsrange(?, ?)", range.begin, range.end)
    end

    def is_buy_ask()  where(type: "Offer::Buy::Ask") end
    def is_buy_bid()  where(type: "Offer::Buy::Bid") end
    def is_sell_ask() where(type: "Offer::Sell::Ask") end
    def is_sell_bid() where(type: "Offer::Sell::Bid") end
  end

  # ----- OVERLAP UTILS -----
  class << self
    def by_overlap_maturation_period(range)
      where("maturation_period && tsrange(?, ?)", range.begin, range.end)
    end

    def by_overlap_maturation_date(date)
      where("maturation_period @> ?::timestamp", date)
    end

    def overlaps(offer)
      base = by_overlap_maturation_period(offer.maturation_period)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end
  end

  def overlap_offers
    self.class.overlaps(self)
  end

  def overlap_contracts
    beg, fin = [self.maturation_period.begin, self.maturation_period.end]
    Contract.by_overlap_maturation_period(beg, fin)
  end

  # ----- CROSS UTILS -----
  class << self
    def with_price(price)
      where(price: price)
    end

    def with_volume(volume)
      where(volume: volume)
    end

    def complements(offer)
      complement = 1.0 - offer.price
      base = with_price(complement)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end

    def crosses(offer)
      complement = 1.0 - offer.price
      base = where('price >= ?', complement)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end
  end

  def cross_offers
    self.class.crosses(self)
  end

  # ----- INSTANCE METHODS -----

  def reserve_value
    self.volume * self.price
  end
  alias_method :value, :reserve_value

  def attach_type
    self.stm_bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def complementary_reserve_value
    self.volume - reserve_value
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

  private

  def default_values
    self.status   ||= 'open'
    self.poolable = false
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  type                :string
#  repo_type           :string
#  user_id             :integer
#  parent_id           :integer
#  position_id         :integer
#  counter_id          :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  poolable            :boolean          default(TRUE)
#  aon                 :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  maturation_period   :tsrange
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  stm_repo_id         :integer
#  stm_bug_id          :integer
#  stm_title           :string
#  stm_status          :string
#  stm_labels          :string
#  stm_xfields         :hstore           not null
#  stm_jfields         :jsonb            not null
#
