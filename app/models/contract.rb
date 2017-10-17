class Contract < ApplicationRecord

  include MatchUtils

  has_paper_trail

  belongs_to :bug , optional: true
  belongs_to :repo, optional: true

  has_many :bids
  has_many :asks
  has_many :bid_users, :through => :bids, :source => "user"
  has_many :ask_users, :through => :asks, :source => "user"

  before_validation :default_values
  validates :status, inclusion: {in: %w(open matured resolved)}
  validates :contract_maturation, presence: true
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

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
    matching_bugs.count > 0
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

  def contract_maturation_str
    self.contract_maturation.strftime("%b-%d %H:%M:%S")
  end

  def matured?
    self.contract_maturation < Time.now
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
      where("contract_maturation < ?", Time.now)
    end

    def expired
      where("contract_maturation < ?", Time.now)
    end

    def unresolved
      where("stm_status != ?", "resolved")
    end

  end

  private

  def default_values
    self.status                ||= 'open'
    self.contract_maturation   ||= Time.now + 1.week
  end
end

# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  type                :string
#  mode                :string
#  status              :string
#  awarded_to          :string
#  contract_maturation :datetime
#  volume              :integer
#  price               :float
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  stm_repo_id         :integer
#  stm_bug_id          :integer
#  stm_title           :string
#  stm_status          :string
#  stm_labels          :string
#  stm_xfields         :hstore           not null
#  stm_jfields         :jsonb            not null
#
