require 'rails_helper'

RSpec.describe Paypro, type: :model do
  def valid_params(opts = {})
    {}
  end

  let(:klas) { described_class                   }
  subject    { klas.new(valid_params)            }

  describe "Associations" do
    it { should respond_to(:ledgers)             }
    it { should respond_to(:users)               }
  end
end

# == Schema Information
#
# Table name: paypros
#
#  id         :bigint(8)        not null, primary key
#  uuid       :string
#  name       :string
#  status     :string           default("open")
#  currency   :string
#  pubkey     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
