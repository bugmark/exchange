require 'rails_helper'

RSpec.describe Repo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
