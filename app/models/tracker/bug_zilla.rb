class Tracker::BugZilla < Tracker

  # has_many :issues, :dependent => :destroy

end

# == Schema Information
#
# Table name: trackers
#
#  id         :bigint(8)        not null, primary key
#  type       :string
#  uuid       :string
#  name       :string
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exid       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
