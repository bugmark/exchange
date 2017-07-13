require 'rails_helper'

RSpec.describe Issue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
