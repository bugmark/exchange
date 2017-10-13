require 'rails_helper'

RSpec.describe Escrow, type: :model do
  def valid_params
    {
      email:    "asdf@qwer.net"   ,
      password: "gggggg"
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  # describe "Associations" do
  #   it { should respond_to(:published_contracts)     }
  #   it { should respond_to(:taken_contracts)         }
  # end

  # describe "Object Creation" do
  #   it { should be_valid }
  #
  #   it 'saves the object to the database' do
  #     subject.save
  #     expect(subject).to be_valid
  #   end
  # end
end

# == Schema Information
#
# Table name: escrows
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  parent_id   :integer
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
