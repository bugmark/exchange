class Repo::BugZilla < Repo

  # has_many :bugs, :dependent => :destroy

end

# == Schema Information
#
# Table name: repos
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  url        :string
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
