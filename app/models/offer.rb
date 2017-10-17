class Offer < ApplicationRecord

  include StatementUtils

  has_paper_trail

  belongs_to :user
  belongs_to :bug,      optional: true  , foreign_key: "stm_bug_id"
  belongs_to :repo,     optional: true  , foreign_key: "stm_repo_id"
  belongs_to :position, optional: true

  validates :status, inclusion: {in: %w(open suspended crossed expired cancelled)}
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

  before_validation :default_values

  class << self
    # ----- SCOPES -----
    def with_status(status)
      where(status: status)
    end

    def poolable
      where(poolable: true)
    end

    def not_poolable
      where(poolable: false)
    end

    def assigned
      where("id IN (SELECT offer_id FROM positions)")
    end

    def unassigned
      where("id NOT IN (SELECT offer_id FROM positions)")
    end

    def by_maturation_period(range)
      where("maturation_period && tsrange(?, ?)", range.begin, range.end)
    end
  end

  # ----- instance methods -----

  def reserve_value
    self.volume * self.price
  end

  def attach_type
    self.stm_bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def complementary_reserve_value
    self.volume - reserve_value
  end

  def matching_bugs
    @bugmatch ||= Bug.match(match_attrs)
  end

  def matching_bids
    # @bidmatch ||= Offer::Buy::Bid.match(cross_attrs)
    []
  end

  def matching_contracts
    @conmatch ||= Contract.match(match_attrs)
  end

  def contract_maturation_str
    self.maturation_date.strftime("%b-%d %H:%M:%S")
  end

  def maturation_date=(date)
    self.maturation_period = date-2.days..date
  end

  def maturation_date
    maturation_period.end
  end

  def matured?
    self.maturation_date < Time.now
  end

  def unmatured?
    ! matured?
  end

  def cross_attrs
    {
      stm_bug_id:  self.stm_bug_id  ,
      stm_repo_id: self.stm_repo_id ,
      stm_title:   self.stm_title   ,
      stm_status:  self.stm_status  ,
      stm_labels:  self.stm_labels  ,
    }
  end

  # def match_attrs
  #   {
  #     stm_bug_id:  self.stm_bug_id   ,
  #     stm_repo_id: self.stm_repo_id  ,
  #     stm_title:   self.stm_title    ,
  #     stm_status:  self.stm_status   ,
  #     stm_labels:  self.stm_labels   ,
  #   }
  # end

  private

  def default_values
    self.status ||= 'open'
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  type                :string
#  repo_type           :string
#  user_id             :integer
#  parent_id           :integer
#  position_id         :integer
#  counter_id          :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  poolable            :boolean          default(TRUE)
#  aon                 :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  maturation_period   :tsrange
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  stm_repo_id         :integer
#  stm_bug_id          :integer
#  stm_title           :string
#  stm_status          :string
#  stm_labels          :string
#  stm_xfields         :hstore           not null
#  stm_jfields         :jsonb            not null
#
