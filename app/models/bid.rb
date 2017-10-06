class Bid < ApplicationRecord

  before_validation :default_values

  belongs_to :user
  belongs_to :contract, optional: true
  belongs_to :bug,      optional: true
  belongs_to :repo,     optional: true

  def xid
    "bid.#{self.id}"
  end

  def matching_bugs
    @buglist ||= Bug.match(match_attrs)
  end

  def reserve
    self.volume * self.price
  end

  def complementary_reserve
    self.volume - self.price
  end

  def contract_maturation_str
    self.contract_maturation.strftime("%b-%d %H:%M:%S")
  end

  def attach_type
    self.bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def matured?
    self.contract_maturation < Time.now
  end

  def unmatured?
    ! matured?
  end

  # -----

  class << self
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

    # -----

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

  def default_values
    self.type         ||= 'Bid::GitHub'
    self.status       ||= 'open'
    self.price        ||= 0.10
    self.contract_maturation ||= Time.now + 1.week
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
end

# == Schema Information
#
# Table name: bids
#
#  id                  :integer          not null, primary key
#  type                :string
#  user_id             :integer
#  contract_id         :integer
#  volume              :integer
#  price               :integer
#  price_limit         :boolean          default(FALSE)
#  all_or_none         :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
