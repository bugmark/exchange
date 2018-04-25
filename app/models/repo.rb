class Repo < ApplicationRecord

  include PgSearch

  with_options foreign_key: "stm_repo_uuid", primary_key: "uuid", :dependent => :destroy do
    has_many :issues
    has_many :offers
    has_many :contracts
  end

  validates :name, uniqueness: true, presence: true

  before_validation :set_defaults

  def xtag
    "rep"
  end

  def xtype
    self.type.gsub("Repo::","")
  end

  def org
    "TBD"
  end

  def has_contracts?
    return false
    contracts.count != 0 || bug_contracts.count != 0
  end

  # ----- SCOPES -----

  class << self
    def github
      where(type: "Repo::GitHub")
    end

    def select_subset
      select(:id, :name, "xfields->'languages' as lang", "jfields->'readme_url' as readme_url", "substring(jfields->>'readme_txt' for 50) as readme_txt")
    end
    alias_method :ss, :select_subset
  end

  private

  def set_defaults
    self.uuid ||= SecureRandom.uuid
  end
end

# == Schema Information
#
# Table name: repos
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
