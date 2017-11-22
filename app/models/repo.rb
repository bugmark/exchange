class PgSearch
  class Configuration
    class Column
      def column_name
        if @column_name.include?('"')
          @column_name
        else
          @connection.quote_column_name(@column_name)
        end
      end
    end
  end
end

class Repo < ApplicationRecord

  include PgSearch

  has_paper_trail

  has_many :bugs     , :dependent => :destroy, :foreign_key => :stm_repo_id
  has_many :offers   , :dependent => :destroy, :foreign_key => :stm_repo_id
  has_many :contracts, :dependent => :destroy, :foreign_key => :stm_repo_id

  validates :name     , uniqueness: true, presence: true

  def xtag
    "rep"
  end

  def xtype
    self.type.gsub("Repo::","")
  end

  def has_contracts?
    return false
    contracts.count != 0 || bug_contracts.count != 0
  end

  # ----- PGSEARCH SCOPES
  pg_search_scope :search_by_name, :against => :name
  # pg_search_scope :search_by_lang, :against => PgSearch::Configuration::HstoreColumn.new('languages', 'en')

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
