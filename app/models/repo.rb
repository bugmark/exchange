class Repo < ApplicationRecord

  has_many :issues, :dependent => :destroy

end

# == Schema Information
#
# Table name: repos
#
#  id         :integer          not null, primary key
#  type       :string
#  url        :string
#  name       :string
#  synced_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
