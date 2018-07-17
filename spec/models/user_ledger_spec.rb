require 'rails_helper'

RSpec.describe UserLedger, type: :model do
  def valid_params(opts = {})
    {}
  end

  let(:klas) { described_class         }
  subject    { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:user)      }
  end
end

# == Schema Information
#
# Table name: user_ledgers
#
#  id          :bigint(8)        not null, primary key
#  uuid        :string
#  user_uuid   :string
#  paypro_uuid :string
#  sequence    :integer
#  name        :string
#  description :string
#  currency    :string
#  balance     :float            default(0.0)
#  status      :string           default("open")
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
