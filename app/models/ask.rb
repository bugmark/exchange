class Ask < ApplicationOffer

  before_validation :default_values

  belongs_to :user
  belongs_to :contract, optional: true
  belongs_to :bug,      optional: true
  belongs_to :repo,     optional: true

  def xtag
    "ask"
  end

  def attach_type
    self.bug_id ? "bugs" : "repos"
  end

  def attach_obj
    bug || repo
  end

  def matching_bid_reserve
    @mb_reserve ||= matching_bids.reduce(0) {|acc, bid| acc + bid.reserve}
  end

  def contract_maturation_str
    self.contract_maturation.strftime("%b-%d %H:%M:%S")
  end

  # ----- scopes -----

  class << self
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

  private

  def default_values
    self.type                ||= 'Ask::GitHub'
    self.status              ||= 'open'
    self.price               ||= 0.10
    self.volume              ||= 1
    self.contract_maturation ||= Time.now + 1.week
  end
end

# == Schema Information
#
# Table name: asks
#
#  id                  :integer          not null, primary key
#  type                :string
#  user_id             :integer
#  contract_id         :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
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
