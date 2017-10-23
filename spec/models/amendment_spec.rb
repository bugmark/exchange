require 'rails_helper'

RSpec.describe Amendment, type: :model do
  def valid_params(opt = {})
    {
    }.merge(opt)
  end

  def gen_amendment(opts = {}) klas.create(valid_params(opts)) end

  let(:contract) { FG.create(:base_contract)  }
  let(:klas)     { described_class            }
  subject        { klas.new(valid_params)     }

  describe "Associations" do
    it { should respond_to(:contract)             }
    it { should respond_to(:positions)            }
    it { should respond_to(:offers)               }
    it { should respond_to(:escrows)              }
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

    it "generates one amendment" do
      expect(Amendment.count).to eq(0)
      obj = gen_amendment(contract_id: contract.id)
      expect(Amendment.count).to eq(1)
      expect(obj).to be_valid
      expect(obj.contract).to be_a(Contract)
      expect(obj.sequence).to eq(1)
    end

    it "generates many amendments" do
      obj1 = gen_amendment(contract_id: contract.id)
      obj2 = gen_amendment(contract_id: contract.id)
      obj3 = gen_amendment(contract_id: contract.id)
      expect(Amendment.count).to eq(3)
      expect(contract.amendments.count).to eq(3)
      expect(obj1.sequence).to eq(1)
      expect(obj2.sequence).to eq(2)
      expect(obj3.sequence).to eq(3)
      expect(obj2.higher_item).to eq(obj1)
    end
  end
end

# == Schema Information
#
# Table name: amendments
#
#  id          :integer          not null, primary key
#  type        :string
#  sequence    :integer
#  contract_id :integer
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
