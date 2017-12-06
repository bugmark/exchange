require 'ext/array'

class Offer < ApplicationRecord

  include MatchUtils

  has_paper_trail

  belongs_to :user            , optional: true
  belongs_to :bug             , optional: true , foreign_key: "stm_bug_id"
  belongs_to :repo            , optional: true , foreign_key: "stm_repo_id"
  has_one    :position                         , foreign_key: "offer_id"
  belongs_to :salable_position, optional: true , foreign_key: "salable_position_id" , class_name: "Position"
  has_one    :reoffer_parent                   , foreign_key: "reoffer_parent_id"   , class_name: "Offer"
  belongs_to :reoffer_child   , optional: true , foreign_key: "reoffer_parent_id"   , class_name: "Offer"
  belongs_to :transfer        , optional: true

  has_one  :prototype         , foreign_key: 'prototype_id', class_name: 'Offer'
  has_many :prototype_children, foreign_key: 'prototype_id', class_name: 'Offer'

  belongs_to :amendment, optional: true
  def escrow() position&.escrow end

  # ----- VALIDATIONS -----

  VALID_STATUS     = %w(open suspended crossed expired canceled)
  VALID_STM_STATUS = %w(open closed) + ["", nil]
  validates :status    , inclusion:    {in: VALID_STATUS     }
  validates :stm_status, inclusion:    {in: VALID_STM_STATUS }
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

  before_validation :default_attributes
  before_validation :update_value

  # ----- BASIC SCOPES -----
  class << self
    def poolable()             where(poolable: true)      end
    def not_poolable()         where(poolable: false)     end
    def with_status(status)    where(status: status)      end
    def without_status(status) where.not(status: status)  end

    VALID_STATUS.each do |status|
      define_method(status.to_sym)          { with_status(status)    }
      define_method("not_#{status}".to_sym) { without_status(status) }
    end

    def assigned
      where("id IN (SELECT offer_id FROM positions)")
    end

    def unassigned
      where("id NOT IN (SELECT offer_id FROM positions)")
    end

    def by_maturation_range(range)
      where("maturation_range && tsrange(?, ?)", range.begin, range.end)
    end
    alias_method :by_range, :by_maturation_range

    def is_buy_fixed()    where(type: "Offer::Buy::Fixed")    end
    def is_buy_unfixed()  where(type: "Offer::Buy::Unfixed")  end
    def is_sell_fixed()   where(type: "Offer::Sell::Fixed")   end
    def is_sell_unfixed() where(type: "Offer::Sell::Unfixed") end

    def is_buy()     where('type like ?', "Offer::Buy%")  end
    def is_sell()    where('type like ?', "Offer::Sell%") end
    def is_unfixed() where('type like ?', "%Unfixed")     end
    def is_fixed()   where('type like ?', "%Fixed")       end

    def select_subset
      select(%i(id type user_id salable_position_id prototype_id reoffer_parent_id volume price value poolable aon status stm_status))
    end
    alias_method :ss, :select_subset
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

    def overlaps_date(date)
      by_overlap_maturation(date)
    end
  end

  def overlap_offers
    match_offers.overlaps(self)
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

    # def align_equal(offer)
    #   base = where('price >= ?', offer.price)
    #   offer.id.nil? ? base : base.where.not(id: offer.id)
    # end

    def align_gte(offer)
      base = where('price >= ?', offer.price)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end

    def align_lte(offer)
      base = where('price <= ?', offer.price)
      offer.id.nil? ? base : base.where.not(id: offer.id)
    end

    # def crosses()
    #
    # end
  end

  def has_qualified_counteroffers?(cross_type)
    qualified_counteroffers(cross_type).length > 0
  end
  alias_method :has_counters?, :has_qualified_counteroffers?

  def crossed_counteroffer
    return nil unless self.status == "crossed"
  end

  # ----- INSTANCE METHODS -----

  def xid
    "#{self.intent}-#{xtag}.#{self&.id || 0}"
  end

  def attach_type
    self.stm_bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def complementary_value
    self.volume - self.value
  end

  def maturation_str
    self.maturation.strftime("%b-%d %H:%M:%S")
  end

  def maturation=(date)
    tdate = date.to_time
    self.maturation_range = tdate-1.day..tdate+1.day
  end

  def maturation
    [self.maturation_range.first, self.maturation_range.last].avg_time
  end

  # ----- predicates -----

  def is_matured?
    self.maturation < BugmTime.now
  end

  def is_unmatured?
    ! is_matured?
  end

  def is_open?
    self.status == 'open'
  end

  def stake
    (self.volume * self.price).to_i
  end

  def is_not_open?
    ! is_open?
  end

  def is_buy?()          self.intent == "buy"                    end
  def is_sell?()         self.intent == "sell"                   end
  def is_unfixed?()      self.side   == "unfixed"                end
  def is_fixed?()        self.side   == "fixed"                  end
  def is_sell_unfixed?() self.type   == "Offer::Sell::Unfixed"   end
  def is_sell_fixed?()   self.type   == "Offer::Sell::Fixed"     end
  def is_buy_unfixed?()  self.type   == "Offer::Buy::Unfixed"    end
  def is_buy_fixed?()    self.type   == "Offer::Buy::Fixed"      end

  private

  def default_attributes
    self.status   ||= 'open'
    self.poolable ||= false
  end

  def update_value
    if self.price && self.volume
      self.value = self.volume * self.price
    else
      self.value = 0
    end
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
#  prototype_id        :integer
#  amendment_id        :integer
#  reoffer_parent_id   :integer
#  salable_position_id :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  value               :float
#  poolable            :boolean          default(TRUE)
#  aon                 :boolean          default(FALSE)
#  status              :string
#  expiration          :datetime
#  maturation_range    :tsrange
#  xfields             :hstore           not null
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  stm_bug_id          :integer
#  stm_repo_id         :integer
#  stm_title           :string
#  stm_status          :string
#  stm_labels          :string
#  stm_xfields         :hstore           not null
#  stm_jfields         :jsonb            not null
#
