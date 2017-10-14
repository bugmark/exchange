class Offer < ApplicationRecord

  belongs_to :user
  belongs_to :bug,      optional: true
  belongs_to :repo,     optional: true

  validates :status, inclusion: {in: %w(open matured resolved)}
  validates :volume, numericality: {only_integer: true, greater_than: 0}
  validates :price,  numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 1.00}

  before_validation :default_values

  class << self

    # ----- scopes -----

    def assigned
      where.not(contract_id: nil)
    end

    def unassigned
      where(contract_id: nil)
    end

    def base_scope
      where(false)
    end

    def by_id(id)
      where(id: id)
    end

    def by_bugid(id)
      where(bug_id: id)
    end

    def by_repoid(id)
      where(repo_id: id)
    end

    def by_title(string)
      where("title ilike ?", string)
    end

    def by_status(status)
      where("status ilike ?", status)
    end

    def by_labels(labels)
      # where(labels: labels)
      where(false)
    end

    def by_maturation_period(range)
      where("maturation_period && tsrange(?, ?)", range.begin, range.end)
    end

    # ----- class methods -----

    def match(attrs)
      attrs.without_blanks.reduce(unassigned) do |acc, (key, val)|
        scope_for(acc, key, val)
      end
    end

    private

    def scope_for(base, key, val)
      case key
        when :bug_id then
          base.by_bugid(val)
        when :repo_id then
          base.by_repoid(val)
        when :bug_title then
          base.by_title(val)
        when :bug_status then
          base.by_status(val)
        when :bug_labels then
          base.by_labels(val)
        else base
      end
    end
  end

  # ----- instance methods -----

  def reserve
    self.volume * self.price
  end

  def attach_type
    self.bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def complementary_reserve
    self.volume - reserve
  end

  def matching_bugs
    @bugmatch ||= Bug.match(match_attrs)
  end

  def matching_bids
    @bidmatch ||= Bid.match(cross_attrs)
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
      bug_id:       self.bug_id,
      repo_id:      self.repo_id,
      bug_title:    self.bug_title,
      bug_status:   self.bug_status,
      bug_labels:   self.bug_labels,
    }
  end

  def match_attrs
    {
      id:      self.bug_id,
      repo_id: self.repo_id,
      title:   self.bug_title,
      status:  self.bug_status,
      labels:  self.bug_labels
    }
  end

  private

  def default_values
    {}
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
#  aon                 :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  maturation_period   :tsrange
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
