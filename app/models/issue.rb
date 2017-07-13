class Issue < ApplicationRecord

  belongs_to :repo

end

# == Schema Information
#
# Table name: issues
#
#  id         :integer          not null, primary key
#  repo_id    :integer
#  foreign_id :string
#  title      :string
#  status     :string
#  synced_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
