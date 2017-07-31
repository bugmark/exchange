class Repo < ApplicationRecord

  has_many :bugs         , :dependent => :destroy
  has_many :contracts    , :dependent => :destroy
  has_many :bug_contracts, :through   => :bugs    , :source => :contracts

  def sync

  end


  # ----- SCOPES -----

  class << self
    def github
      where(type: "Repo::Github")
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
#  url        :string
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
