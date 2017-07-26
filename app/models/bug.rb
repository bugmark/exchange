class Bug < ApplicationRecord

  belongs_to :repo
  has_many :contracts, :dependent => :destroy

  # ----- SCOPES -----

  class << self

    def base_scope
      where(false)
    end

    def by_id(id)
      where(id: id)
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
      where(labels: labels)
    end

    # -----

    def match(attrs)
      attrs.without_nils.reduce(base_scope) do |acc, (key, val)|
        scope_for(acc, key, val)
      end
    end

    private

    def scope_for(base, key, val)
      case key
        when :id then
          base.by_id(val)
        when :repo_id then
          base.by_repoid(val)
        when :title then
          base.by_title(val)
        when :status then
          base.by_status(val)
        when :labels then
          base.by_labels(val)
        else base
      end
    end

  end
end

# == Schema Information
#
# Table name: bugs
#
#  id          :integer          not null, primary key
#  repo_id     :integer
#  type        :string
#  api_url     :string
#  http_url    :string
#  title       :string
#  description :string
#  status      :string
#  labels      :text             default([]), is an Array
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
