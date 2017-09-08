class Bug < ApplicationRecord

  belongs_to :repo
  has_many :contracts, :dependent => :destroy

  def xid
    "bug.#{self.id}"
  end

  def xtype
    self.type.gsub("Bug::","")
  end

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
      # where(labels: labels)
      where(false)
    end

    # -----

    def match(attrs)
      attrs.without_blanks.reduce(base_scope) do |acc, (key, val)|
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
#  title       :string
#  description :string
#  status      :string
#  labels      :text             default([]), is an Array
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
