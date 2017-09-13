class Repo < ApplicationRecord

  has_many :bugs         , :dependent => :destroy
  has_many :contracts    , :dependent => :destroy
  has_many :bug_contracts, :through   => :bugs    , :source => :contracts

  validates :name     , uniqueness: true, presence: true

  def xid
    "rep.#{self.id}"
  end

  def xtype
    self.type.gsub("Repo::","")
  end

  def has_contracts?
    contracts.count != 0 || bug_contracts.count != 0
  end

  # ----- SCOPES -----

  class << self
    def github
      where(type: "Repo::GitHub")
    end
  end
end

# == Schema Information
#
# Table name: repos
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
