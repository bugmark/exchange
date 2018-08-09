# Generic Issue
class Issue < ApplicationRecord

  include MatchUtils
  include PgSearch

  before_validation :set_defaults
  after_save        :update_stm_ids

  with_options primary_key: 'uuid' do
    belongs_to :tracker , :foreign_key => :stm_tracker_uuid
  end

  with_options foreign_key: 'stm_issue_uuid', primary_key: 'uuid' do
    has_many   :offers    , :dependent  => :destroy
    has_many   :offers_bf , :class_name => 'Offer::Buy::Fixed'
    has_many   :offers_bu , :class_name => 'Offer::Buy::Unfixed'
    has_many   :offers_sf , :class_name => 'Offer::Sell::Fixed'
    has_many   :offers_su , :class_name => 'Offer::Sell::Unfixed'
    has_many   :contracts , :dependent  => :destroy
  end

  hstore_accessor :stm_xfields, :html_url => :string
  # jsonb_accessor  :stm_jfields, :comments  => :string

  VALID_STM_STATUS = %w[open closed].freeze

  validates :stm_status, inclusion: {in: VALID_STM_STATUS }

  # ----- SCOPES -----
  class << self
    # ------------------------------------------------------------------------
    # Cross-Model Scopes
    #
    # START BY READING THIS REFERENCE!
    # http://aokolish.me/blog/2015/05/26/how-to-simplify-active-record-scopes-that-reference-other-tables/
    #
    # Examples:
    # - Issue.offered.merge(Offer.open)
    # - Issue.offered.merge(Offer.crossed)
    # - Issue.contracted.merge(Contract.open)
    # - Issue.contracted.merge(Contract.resolved)
    # - Issue.contracted.merge(Contract.unresolved)
    #
    # Note that you can use `join_offer`, `join_contract` and `distinct_issue`
    # in standalone operations:
    # - Issue.join_offer.merge(Offer.open).distinct_issue
    # - Issue.join_contract.merge(Contract.open).distinct_issue
    #
    # You can also compose with Issue-specific scopes:
    # - Issue.offered.merge(Offer.open).closed
    # - Issue.offered.merge(Offer.open).open
    #

    def join_offer
      joins('LEFT JOIN offers ON offers.stm_issue_uuid = issues.uuid')
    end

    def join_contract
      joins('LEFT JOIN contracts ON contracts.stm_issue_uuid = issues.uuid')
    end

    def attached
      join_offer
        .join_contract
        .where('offers.id IS NOT NULL OR contracts.id IS NOT NULL')
        .distinct_issue
    end

    def unattached
      unoffered.uncontracted
    end

    def offered
      join_offer
        .where('offers.id IS NOT NULL')
        .distinct_issue
    end

    def unoffered
      join_offer
        .where('offers.id IS NULL')
        .distinct_issue
    end

    def contracted
      join_contract
        .where('contracts.id IS NOT NULL')
        .distinct_issue
    end

    def uncontracted
      join_contract
        .where('contracts.id IS NULL')
        .distinct_issue
    end

    def distinct_issue
      select('DISTINCT issues.*')
    end

    # ------------------------------------------------------------------------

    def open
      where(stm_status: 'open')
    end

    def closed
      where(stm_status: 'closed')
    end

    def by_hexid(hexid)
      where('stm_body like ?', "%#{hexid.to_s.gsub("/", "")}%")
    end

    def select_subset
      alt = []
      alt << "substring(stm_jfields->>'comments' for 20) as comments"
      alt << "substring(stm_title for 20) as title"
      select(%i(id uuid type stm_tracker_uuid stm_issue_uuid stm_status stm_labels) + alt)
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
    "issue"
  end

  def xtype
    self.type&.gsub("Issue::","")
  end

  def hexid
    self.stm_body.scan(/(>|^| )\/(\h\h\h\h\h\h)/)&.first&.last
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
#  id               :bigint(8)        not null, primary key
#  type             :string
#  uuid             :string
#  exid             :string
#  sequence         :integer
#  xfields          :hstore           not null
#  jfields          :jsonb            not null
#  synced_at        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stm_issue_uuid   :string
#  stm_tracker_uuid :string
#  stm_title        :string
#  stm_body         :string
#  stm_status       :string
#  stm_labels       :string
#  stm_trader_uuid  :string
#  stm_group_uuid   :string
#  stm_currency     :string
#  stm_paypro_uuid  :string
#  stm_comments     :jsonb            not null
#  stm_jfields      :jsonb            not null
#  stm_xfields      :hstore           not null
#
