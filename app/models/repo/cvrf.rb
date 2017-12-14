class Repo::Cvrf < Repo

  # has_many :bugs, :dependent => :destroy

end

# == Schema Information
#
# Table name: repos
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exid       :string
#  uuid       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
