class Contract < ApplicationRecord
  belongs_to :bug, optional: true
  belongs_to :repo, optional: true

  belongs_to :publisher, class_name: "User", foreign_key: 'publisher_id'
  belongs_to :counterparty, class_name: "User", foreign_key: 'counterparty_id', optional: true

  before_validation :default_values
  validates :status, inclusion: {in: %w(open withdrawn taken lapsed resolved)}
  validates :matures_at, presence: true

  # VALID STATUSES
  # > open      - can be taken
  # > withdrawn - withdrawn by publisher (before taken)
  # > taken     - taken by a counterparty
  # > lapsed    - expired before being taken
  # > resolved  - in favor of publisher or counterparty

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
      match_assertion ? "publisher" : "counterparty"
    end
  end

  def to_i
    self.id
  end

  # ----- SCOPES -----

  class << self
    def pending_resolution
      expired.unresolved
    end

    def expired
      where("matures_at < ?", Time.now)
    end

    def unresolved
      where("status != ?", "resolved")
    end
  end

  private

  def default_values
    self.status       ||= 'open'
    self.bug_presence ||= true
    self.matures_at   ||= Time.now + 1.week
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
#  id              :integer          not null, primary key
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_type   :string
#  currency_amount :float
#  terms           :string
#  status          :string
#  awarded_to      :string
#  matures_at      :datetime
#  repo_id         :integer
#  bug_id          :integer
#  bug_title       :string
#  bug_status      :string
#  bug_labels      :string
#  bug_presence    :boolean
#  jfields         :jsonb            not null
#  exref           :string
#  uuref           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
