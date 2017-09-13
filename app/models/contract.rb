class Contract < ApplicationRecord
  belongs_to :bug , optional: true
  belongs_to :repo, optional: true

  has_many :bids
  has_many :asks
  has_many :bid_users, :through => :bids, :source => "user"
  has_many :ask_users, :through => :asks, :source => "user"

  before_validation :default_values
  validates :status, inclusion: {in: %w(open matured resolved)}
  validates :contract_maturation, presence: true

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
    bids.reduce(0) {|acc, bid| acc + bid.token_value}
  end

  def ask_tokens
    asks.reduce(0) {|acc, ask| acc + ask.token_value}
  end

  def distribution_tokens
    bid_tokens + ask_tokens
  end

  def bidder_allocation
    total_bids = bid_tokens
    total_dist = distribution_tokens
    bids.reduce({}) do |acc, bid|
      acc[bid.id] = ((bid.token_value.to_f / total_bids) * total_dist).to_i
      acc
    end
  end

  # VALID STATUSES
  # > open      - active
  # > matured   - past mature date
  # > resolved  - assigned

  # returns list of matching bugs
  def match_list
    @bugmatch ||= Bug.match(match_attrs)
  end

  # returns boolean result of the match assertion
  def match_assertion
    match_length = match_list.count
    if self.bug_presence
      match_length > 0
    else
      match_length == 0
    end
  end

  def awardee
    self.awarded_to || begin
      match_assertion ? "bidder" : "asker"
    end
  end

  def awardee_user
    self.send awardee.to_sym
  end

  def to_i
    self.id
  end

  def xid
    "con.#{self.id}"
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
    def constant
      where(ownership: 'constant')
    end

    def extensible
      where(ownership: 'extensible')
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
      where("status != ?", "resolved").where("status != ?", "open")
    end

  end

  private

  def default_values
    self.status       ||= 'open'
    self.bug_presence ||= true
    self.ownership    ||= 'constant'
    self.contract_maturation   ||= Time.now + 1.week
  end

  def match_attrs
    {
      id:      self.bug_id,
      repo_id: self.repo_id,
      title:   self.bug_title,
      status:  self.bug_status,
      labels:  self.bug_labels
    }
  end
end

# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  type                :string
#  status              :string
#  ownership           :string
#  awarded_to          :string
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  bug_presence        :boolean
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
