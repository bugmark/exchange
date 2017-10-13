class Offer::Bid < Offer

  before_validation :default_values

  belongs_to :user
  belongs_to :contract, optional: true
  belongs_to :bug,      optional: true
  belongs_to :repo,     optional: true

  def xtag
    "bid"
  end

  def attach_obj
    bug || repo
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

    def by_maturation_period(range)
      where("maturation_period && tsrange(?, ?)", range.begin, range.end)
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
    self.type              ||= 'Bid::GitHub'
    self.status            ||= 'open'
    self.price             ||= 0.10
    self.maturation_period ||= Time.now+1.minute..Time.now+1.week
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
