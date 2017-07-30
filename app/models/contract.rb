class Contract < ApplicationRecord
  belongs_to :bug   , optional: true
  belongs_to :repo  , optional: true

  # validates :currency_amount, numericality: {less_than: 15}

  before_validation :default_values

  # VALID STATUSES
  # > open      - can be taken
  # > withdrawn - withdrawn by publisher (before taken)
  # > taken     - taken by a counterparty
  # > lapsed    - expired before being taken
  # > resolved  - in favor of publisher or counterparty

  validates :status, inclusion: { in: %w(open withdrawn taken lapsed resolved)}

  def matching_bugs
    @bugmatch ||= Bug.match(match_attrs)
  end

  # ----- SCOPES -----

  class << self
    def pending_resolution
      expired.unresolved
    end

    def expired
      where("expires_at < ?", Time.now)
    end

    def unresolved
      where("status != ?", "resolved")
    end
  end

  def awaredee
    self.awarded_to || "TBD"   # add some logic here to calculate awardee
  end

  private

  def default_values
    self.status       ||= 'open'
    self.bug_presence ||= true
  end

  def match_attrs
    {
      id:       self.bug_id       ,
      repo_id:  self.repo_id      ,
      title:    self.bug_title    ,
      status:   self.bug_status   ,
      labels:   self.bug_labels
    }
  end
end
