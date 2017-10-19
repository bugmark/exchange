class Offer < ApplicationRecord

  include MatchUtils

  has_paper_trail

  belongs_to :user
  belongs_to :bug,      optional: true  , foreign_key: "stm_bug_id"
  belongs_to :repo,     optional: true  , foreign_key: "stm_repo_id"
  belongs_to :position, optional: true  , foreign_key: "buy_offer_id"
  belongs_to :parent_position, optional: true, class_name: "Position", :foreign_key => :parent_position_id

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
      where("id IN (SELECT buy_offer_id FROM positions)")
    end

    def unassigned
      where("id NOT IN (SELECT buy_offer_id FROM positions)")
    end

    def by_maturation_range(range)
      where("maturation_range && tsrange(?, ?)", range.begin, range.end)
    end

    def is_buy_ask()  where(type: "Offer::Buy::Ask")  end
    def is_buy_bid()  where(type: "Offer::Buy::Bid")  end
    def is_sell_ask() where(type: "Offer::Sell::Ask") end
    def is_sell_bid() where(type: "Offer::Sell::Bid") end

    def on_bid_side() is_buy_bid.or(is_sell_bid)       end
    def on_ask_side() is_buy_ask.or(is_sell_ask)       end
    def with_buy_intent() is_buy_ask.or(is_buy_bid)    end
    def with_sell_intent() is_sell_ask.or(is_sell_bid) end
  end

  # ----- OVERLAP UTILS -----
  class << self
    def by_overlap_maturation_range(range)
      where("maturation_range && tsrange(?, ?)", range.begin, range.end)
    end

    def by_overlap_maturation(date)
      where("maturation_range @> ?::timestamp", date)
    end

    def overlaps(offer)
      base = by_overlap_maturation_range(offer.maturation_range)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end
  end

  def overlap_offers
    self.class.overlaps(self)
  end

  def overlap_contracts
    beg, fin = [self.maturation_range.begin, self.maturation_range.end]
    Contract.by_overlap_maturation_range(beg, fin)
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

  def maturation_str
    self.maturation.strftime("%b-%d %H:%M:%S")
  end

  def maturation=(date)
    tdate = date.to_time
    self.maturation_range = tdate-2.days..tdate
  end

  def maturation
    maturation_range.end
  end

  def matured?
    self.maturation < Time.now
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
#  id                 :integer          not null, primary key
#  type               :string
#  repo_type          :string
#  user_id            :integer
#  reoffer_parent_id  :integer
#  parent_position_id :integer
#  volume             :integer          default(1)
#  price              :float            default(0.5)
#  poolable           :boolean          default(TRUE)
#  aon                :boolean          default(FALSE)
#  status             :string
#  expiration         :datetime
#  maturation         :datetime
#  maturation_range   :tsrange
#  jfields            :jsonb            not null
#  exref              :string
#  uuref              :string
#  stm_bug_id         :integer
#  stm_repo_id        :integer
#  stm_title          :string
#  stm_status         :string
#  stm_labels         :string
#  stm_xfields        :hstore           not null
#  stm_jfields        :jsonb            not null
#
