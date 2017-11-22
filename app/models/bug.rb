class Bug < ApplicationRecord

  include MatchUtils
  include PgSearch

  has_paper_trail

  after_save :update_stm_ids

  belongs_to :repo     , :foreign_key => :stm_repo_id
  has_many   :offers   , :foreign_key => :stm_bug_id, :dependent  => :destroy
  has_many   :offers_bf, :foreign_key => :stn_bug_id, :class_name => "Offer::Buy::Fixed"
  has_many   :offers_bu, :foreign_key => :stn_bug_id, :class_name => "Offer::Buy::Unfixed"
  has_many   :contracts, :foreign_key => :stm_bug_id, :dependent  => :destroy

  hstore_accessor :xfields  , :html_url  => :string    # add field to hstore

  VALID_STM_STATUS = %w(open closed) + ["", nil]
  validates :stm_status, inclusion:    {in: VALID_STM_STATUS }

  # ----- PGSEARCH SCOPES -----
  pg_search_scope :search_by_title, :against => :stm_title

  # ----- INSTANCE METHODS ----- #

  def xtag
    "bug"
  end

  def xtype
    self.type.gsub("Bug::","")
  end

  def has_offers?()    offers.count > 0    end
  def has_contracts?() contracts.count > 0 end

  private

  def update_stm_ids
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
