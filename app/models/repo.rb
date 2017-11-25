class Repo < ApplicationRecord

  include PgSearch

  has_paper_trail

  has_many :bugs      , :dependent => :destroy, :foreign_key => :stm_repo_id
  has_many :offers    , :dependent => :destroy, :foreign_key => :stm_repo_id
  has_many :contracts , :dependent => :destroy, :foreign_key => :stm_repo_id

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

  class << self
    def combined_search(query)
      rank = <<-RANK
        ts_rank(to_tsvector('english', languages),             plainto_tsquery('#{query}')) +
        ts_rank(to_tsvector('english', jfields->'readme_txt'), plainto_tsquery('#{query}'))
      RANK
      field1 = "to_tsvector('english', languages            )"
      field2 = "to_tsvector('english', jfields->'readme_txt')"
      qry    = "plainto_tsquery('english', '#{query}')"
      where("#{field1} @@ #{qry} or #{field2} @@ #{qry}").order("#{rank} desc")
    end

    def language_search(query)
      rank = <<-RANK
        ts_rank(to_tsvector('english', languages), plainto_tsquery('#{query}'))
      RANK
      field = "to_tsvector('english', languages)"
      where("#{field} @@ plainto_tsquery('english', '#{query}')").order("#{rank} desc")
    end

    def readme_search(query)
      rank = <<-RANK
        ts_rank(to_tsvector('english', jfields -> 'readme_txt'), plainto_tsquery('#{query}'))
      RANK
      field = "to_tsvector('english', jfields -> 'readme_txt')"
      where("#{field} @@ plainto_tsquery('english', '#{query}')").order("#{rank} desc")
    end
  end

  # ----- SCOPES -----

  class << self
    def github
      where(type: "Repo::GitHub")
    end

    def select_subset
      select(:id, :name, "xfields->'languages' as lang", "substring(jfields->>'readme_txt' for 100) as readme")
    end
    alias_method :ss, :select_subset
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
