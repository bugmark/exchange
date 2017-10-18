class Contract < ApplicationRecord

  include MatchUtils

  has_paper_trail

  # belongs_to :bug , optional: true
  # belongs_to :repo, optional: true

  # has_many :bids
  # has_many :asks
  # has_many :bid_users, :through => :bids, :source => "user"
  # has_many :ask_users, :through => :asks, :source => "user"

  has_many :escrows, -> {order(:sequence => :asc)}

  has_many :positions, :through => :escrows

  before_validation :default_values

  validates :status, inclusion: {in: %w(open matured resolved)}
  validates :maturation, presence: true

  # ----- SCOPES -----
  class << self
    def reward
      where(mode: 'reward')
    end

    def forecast
      where(mode: 'forecast')
    end

    def pending_resolution
      expired.unresolved
    end

    def matured
      where("maturation < ?", Time.now)
    end

    def expired
      where("maturation < ?", Time.now)
    end

    def unresolved
      where("stm_status != ?", "resolved")
    end
  end

  # ----- OVERLAP UTILS -----
  class << self
    def by_overlap_maturation_range(beg, fin)
      where('maturation > ?::timestamp', beg).
        where('maturation < ?::timestamp', fin)
    end
  end

  def overlap_offers
    Offer.by_overlap_maturation(self.maturation)
  end

  # ----- INSTANCE METHODS -----

  def users
    (bid_users + ask_users).uniq
  end

  def attach_type
    self.bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def bid_tokens
    # bids.reduce(0) {|acc, bid| acc + bid.token_value}
    0
  end

  def ask_tokens
    # asks.reduce(0) {|acc, ask| acc + ask.token_value}
    0
  end

  def distribution_tokens
    bid_tokens + ask_tokens
  end

  def bidder_allocation
    total_bids = bid_tokens
    total_dist = distribution_tokens
    bids.reduce({}) do |acc, bid|
      # acc[bid.id] = ((bid.token_value.to_f / total_bids) * total_dist).to_i
      acc[bid.id] = 1
      acc
    end
  end

  # VALID STATUSES
  # > open      - active
  # > matured   - past mature date
  # > resolved  - assigned

  def match_assertion
    match_bugs.count > 0
  end

  def awardee
    self.awarded_to || begin
      match_assertion ? "bidder" : "asker"
    end
  end

  def awardee_user
    self.send awardee.to_sym
  end

  def xtag
    "con"
  end

  def maturation_str
    self.maturation.strftime("%b-%d %H:%M:%S")
  end

  def matured?
    self.maturation < Time.now
  end

  def unmatured?
    ! matured?
  end

  def resolved?
    self.status == 'resolved'
  end

  def unresolved?
    ! resolved?
  end

  private

  def default_values
    self.status       ||= 'open'
    self.maturation   ||= Time.now + 1.week
  end
end

# == Schema Information
#
# Table name: contracts
#
#  id          :integer          not null, primary key
#  type        :string
#  mode        :string
#  status      :string
#  awarded_to  :string
#  maturation  :datetime
#  jfields     :jsonb            not null
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  stm_bug_id  :integer
#  stm_repo_id :integer
#  stm_title   :string
#  stm_status  :string
#  stm_labels  :string
#  stm_xfields :hstore           not null
#  stm_jfields :jsonb            not null
#
