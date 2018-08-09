# Generic Isssue Tracker.  Has many issues.
class Tracker < ApplicationRecord

  include PgSearch

  with_options :foreign_key => 'stm_tracker_uuid', :primary_key => 'uuid', :dependent => :destroy do
    has_many :issues
    has_many :offers
    has_many :contracts
  end

  validates :name, uniqueness: true, presence: true

  before_validation :set_defaults

  def xtag
    'tracker'
  end

  def xtype
    self.type.gsub('Tracker::', '')
  end

  def org
    'TBD'
  end

  def has_contracts?
    false
    # contracts.count != 0 || bug_contracts.count != 0
  end

  def readme_txt() '' end

  def languages() '' end

  # ----- SCOPES -----

  class << self
    def github
      where(type: 'Tracker::GitHub')
    end

    def select_subset
      var1 = "xfields->'languages' as lang"
      var2 = "jfields->'readme_url' as readme_url"
      var3 = "substring(jfields->>'readme_txt' for 50) as readme_txt"
      select(:id, :name, var1, var2, var3)
    end
    alias ss select_subset
  end

  private

  def set_defaults
    self.uuid ||= SecureRandom.uuid
  end
end

# == Schema Information
#
# Table name: trackers
#
#  id         :bigint(8)        not null, primary key
#  type       :string
#  uuid       :string
#  name       :string
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exid       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
