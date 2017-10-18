require 'rails_helper'

RSpec.describe Escrow, type: :model do
  def valid_params
    {
      # email:    "asdf@qwer.net"   ,
      # password: "gggggg"
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:contract)             }
    it { should respond_to(:parent )              }
    it { should respond_to(:child)                }
    it { should respond_to(:positions)            }
    it { should respond_to(:bid_positions)        }
    it { should respond_to(:ask_positions)        }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end
end

# == Schema Information
#
# Table name: escrows
#
#  id          :integer          not null, primary key
#  sequence    :integer
#  contract_id :integer
#  bid_value   :float            default(0.0)
#  ask_value   :float            default(0.0)
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
