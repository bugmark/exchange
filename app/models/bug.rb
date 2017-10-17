class Bug < ApplicationRecord

  include MatchUtils

  has_paper_trail

  belongs_to :repo,      :foreign_key => :stm_repo_id
  has_many   :contracts, :dependent   => :destroy
  has_many   :bids
  has_many   :asks

  hstore_accessor :xfields  , :html_url  => :string    # add field to hstore

  def xtag
    "bug"
  end

  def xtype
    self.type.gsub("Bug::","")
  end
end

# == Schema Information
#
# Table name: bugs
#
#  id          :integer          not null, primary key
#  type        :string
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  stm_repo_id :integer
#  stm_bug_id  :integer
#  stm_title   :string
#  stm_status  :string
#  stm_labels  :string
#  stm_xfields :hstore           not null
#  stm_jfields :jsonb            not null
#
