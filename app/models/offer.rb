class Offer < ApplicationRecord

  include MatchUtils

  has_paper_trail

  belongs_to :user    , optional: true
  belongs_to :bug     , optional: true  , foreign_key: "stm_bug_id"
  belongs_to :repo    , optional: true  , foreign_key: "stm_repo_id"
  belongs_to :position, optional: true  , foreign_key: "buy_offer_id"
  belongs_to :parent_position, optional: true, class_name: "Position", :foreign_key => :parent_position_id
  has_one    :reoffer_parent                 , class_name: "Offer"   , :foreign_key => :reoffer_parent_id
  belongs_to :reoffer_child  , optional: true, class_name: "Offer"   , :foreign_key => :reoffer_parent_id
  belongs_to :transfer       , optional: true

  validates :status, inclusion:    {in: %w(open suspended crossed expired retracted)}
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

  belongs_to :amendment, optional: true

  before_validation :default_values

  # -----

  def xid
    "#{xtag}-#{self.intent}.#{self&.id || 0}"
  end

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

    def by_maturation_range(range)
      where("maturation_range && tsrange(?, ?)", range.begin, range.end)
    end

    def is_buy_ask()  where(type: "Offer::Buy::Ask")  end
    def is_buy_bid()  where(type: "Offer::Buy::Bid")  end
    def is_sell_ask() where(type: "Offer::Sell::Ask") end
    def is_sell_bid() where(type: "Offer::Sell::Bid") end

    def is_bid()  where('type like ?', "%Bid") end
    def is_ask()  where('type like ?', "%Ask") end
    def is_buy()  where('type like ?', "Offer::Buy%") end
    def is_sell() where('type like ?', "Offer::Sell%") end
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
    def with_volume(volume)
      where(volume: volume)
    end

    def align_complement(offer)
      complement = 1.0 - offer.price
      base = where('price >= ?', complement)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end

    def align_equal(offer)
      base = where('price >= ?', offer.price)
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
    self.maturation_range.end
  end

  # ----- predicates -----

  def is_matured?
    self.maturation < Time.now
  end

  def is_unmatured?
    ! is_matured?
  end

  def is_open?
    self.status == 'open'
  end

  def is_not_open?
    ! is_open?
  end

  def is_sell_bid?() self.type == "Offer::Sell::Bid"   end
  def is_sell_ask?() self.type == "Offer::Sell::Ask"   end
  def is_buy_bid?()  self.type == "Offer::Buy::Bid"    end
  def is_buy_ask?()  self.type == "Offer::Buy::Ask"    end

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
#  amendment_id       :integer
#  reoffer_parent_id  :integer
#  parent_position_id :integer
#  volume             :integer          default(1)
#  price              :float            default(0.5)
#  poolable           :boolean          default(TRUE)
#  aon                :boolean          default(FALSE)
#  status             :string
#  expiration         :datetime
#  maturation_range   :tsrange
#  xfields            :hstore           not null
#  jfields            :jsonb            not null
#  exref              :string
#  uuref              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  stm_bug_id         :integer
#  stm_repo_id        :integer
#  stm_title          :string
#  stm_status         :string
#  stm_labels         :string
#  stm_xfields        :hstore           not null
#  stm_jfields        :jsonb            not null
#
