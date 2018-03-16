class Issue < ApplicationRecord

  include MatchUtils
  include PgSearch

  has_paper_trail

  before_validation :set_defaults
  after_save        :update_stm_ids

  with_options primary_key: "uuid" do
    belongs_to :repo      , :foreign_key => :stm_repo_uuid
  end

  with_options foreign_key: "stm_issue_uuid", primary_key: "uuid" do
    has_many   :offers    , :dependent  => :destroy
    has_many   :offers_bf , :class_name => "Offer::Buy::Fixed"
    has_many   :offers_bu , :class_name => "Offer::Buy::Unfixed"
    has_many   :contracts , :dependent  => :destroy
  end

  hstore_accessor :stm_xfields, :html_url  => :string
  jsonb_accessor  :stm_jfields, :comments  => :string

  VALID_STM_STATUS = %w(open closed)

  validates :stm_status, inclusion:    {in: VALID_STM_STATUS }

  # ----- SCOPES -----
  class << self
    def open
      where(stm_status: 'open')
    end

    def closed
      where(stm_status: 'closed')
    end

    def select_subset
      alt = []
      alt << "substring(stm_jfields->>'comments' for 20) as comments"
      alt << "substring(stm_title for 20) as title"
      select(%i(id uuid type stm_repo_uuid stm_issue_uuid stm_status stm_labels) + alt)
    end
    alias_method :ss, :select_subset
  end

  # ----- PGSEARCH SCOPES -----

  pg_search_scope :search_by_title, :against => :stm_title

  # ----- INSTANCE METHODS -----

  def offer_overlap_on(date)
    offers.open.overlaps_date(date).order('value asc')
  end

  def xtag
    "bug"
  end

  def xtype
    self.type.gsub("Issue::","")
  end

  def has_offers?()    offers.count > 0    end
  def has_contracts?() contracts.count > 0 end
  def num_contracts()  contracts.count     end

  private

  def set_defaults
    self.stm_status ||= "open"
  end

  def update_stm_ids
    return if self.uuid.nil?
    return if self.stm_issue_uuid.present?
    update_attribute :stm_issue_uuid, self.uuid
  end
end

# == Schema Information
#
# Table name: issues
#
#  id             :integer          not null, primary key
#  type           :string
#  uuid           :string
#  exid           :string
#  xfields        :hstore           not null
#  jfields        :jsonb            not null
#  synced_at      :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  stm_issue_uuid :string
#  stm_repo_uuid  :string
#  stm_title      :string
#  stm_status     :string
#  stm_labels     :string
#  stm_xfields    :hstore           not null
#  stm_jfields    :jsonb            not null
#
