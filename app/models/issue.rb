class Issue < ApplicationRecord

  belongs_to :repo

end

# == Schema Information
#
# Table name: issues
#
#  id         :integer          not null, primary key
#  repo_id    :integer
#  api_url    :string
#  http_url   :string
#  title      :string
#  status     :string
#  labels     :text             default([]), is an Array
#  synced_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
