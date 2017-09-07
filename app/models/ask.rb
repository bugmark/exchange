class Ask < ApplicationRecord

  belongs_to :user
  belongs_to :contract, optional: true
  belongs_to :bug,      optional: true
  belongs_to :repo,     optional: true

  def xid
    "ask.#{self.id}"
  end

  def match_list
    []
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
