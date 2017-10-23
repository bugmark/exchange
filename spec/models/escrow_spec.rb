require 'rails_helper'

RSpec.describe Escrow, type: :model do
  def valid_params(opt = {})
    {
      # email:    "asdf@qwer.net"   ,
      # password: "gggggg"
    }.merge(opt)
  end

  def gen_escrow(opts = {}) klas.create(valid_params(opts)) end

  let(:contract) { FG.create(:base_contract)  }
  let(:klas)     { described_class            }
  subject        { klas.new(valid_params)     }

  describe "Associations" do
    it { should respond_to(:contract)             }
    it { should respond_to(:positions)            }
    it { should respond_to(:bid_positions)        }
    it { should respond_to(:ask_positions)        }
    it { should respond_to(:amendment)            }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Sequence" do
    before(:each) { hydrate(contract)}

    it "generates one escrow" do
      expect(Escrow.count).to eq(0)
      esc = gen_escrow(contract_id: contract.id)
      expect(Escrow.count).to eq(1)
      expect(esc).to be_valid
      expect(esc.contract).to be_a(Contract)
      expect(esc.sequence).to eq(1)
    end

    it "generates many escrows" do
      esc1 = gen_escrow(contract_id: contract.id)
      esc2 = gen_escrow(contract_id: contract.id)
      esc3 = gen_escrow(contract_id: contract.id)
      expect(Escrow.count).to eq(3)
      expect(contract.escrows.count).to eq(3)
      expect(esc1.sequence).to eq(1)
      expect(esc2.sequence).to eq(2)
      expect(esc3.sequence).to eq(3)
      expect(esc3.higher_item).to eq(esc2)
    end
  end
end

# == Schema Information
#
# Table name: escrows
#
#  id           :integer          not null, primary key
#  sequence     :integer
#  contract_id  :integer
#  amendment_id :integer
#  bid_value    :float            default(0.0)
#  ask_value    :float            default(0.0)
#  exref        :string
#  uuref        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
