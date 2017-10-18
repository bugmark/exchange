class Bug < ApplicationRecord

  include MatchUtils

  has_paper_trail

  after_save :update_stm_bug_id

  belongs_to :repo,      :foreign_key => :stm_repo_id
  # has_many   :contracts, :dependent   => :destroy
  has_many   :bids
  has_many   :asks

  hstore_accessor :xfields  , :html_url  => :string    # add field to hstore

  def xtag
    "bug"
  end

  def xtype
    self.type.gsub("Bug::","")
  end

  private

  def update_stm_bug_id
    return if self.id.nil?
    return if self.stm_bug_id.present?
    update_attribute :stm_bug_id, self.id
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
#  stm_bug_id  :integer
#  stm_repo_id :integer
#  stm_title   :string
#  stm_status  :string
#  stm_labels  :string
#  stm_xfields :hstore           not null
#  stm_jfields :jsonb            not null
#
