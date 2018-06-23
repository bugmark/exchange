require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  def valid_params(opts = {})
    {}
  end

  let(:klas) { described_class                   }
  subject    { klas.new(valid_params)            }

  describe "Associations" do
    it { should respond_to(:owner)               }
    it { should respond_to(:users)               }
  end
end

# == Schema Information
#
# Table name: user_groups
#
#  id         :bigint(8)        not null, primary key
#  uuid       :string
#  owner_uuid :string
#  name       :string
#  tags       :string
#  jfields    :jsonb            not null
#  status     :string           default("open")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
