class Ask < ApplicationRecord

  belongs_to :user
  belongs_to :contract, optional: true
  belongs_to :bug,      optional: true
  belongs_to :repo,     optional: true

  def xid
    "ask.#{self.id}"
  end

  def cross_list
    @bidcross ||= Bid.cross(cross_attrs)
  end

  def contract_maturation_str
    self.contract_maturation.strftime("%b-%d %H:%M:%S")
  end

  # ----- scopes -----

  class << self
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

  private

  def cross_attrs
    {
      bug_id:       self.bug_id,
      repo_id:      self.repo_id,
      bug_title:    self.bug_title,
      bug_status:   self.bug_status,
      bug_labels:   self.bug_labels,
      bug_presence: self.bug_presence
    }
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
#  token_value         :integer
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  bug_presence        :boolean
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
