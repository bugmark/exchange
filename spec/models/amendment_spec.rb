require 'rails_helper'

RSpec.describe Amendment, type: :model do
  def valid_params(opt = {})
    {}.merge(opt)
  end

  def gen_amendment(opts = {}) klas.create(valid_params(opts)) end

  let(:contract) { FBX.expand_obf.contract    }
  let(:klas)     { described_class            }
  subject        { klas.new(valid_params)     }

  describe "Associations" do
    it { should respond_to(:contract)             }
    it { should respond_to(:positions)            }
    it { should respond_to(:offers)               }
    it { should respond_to(:escrow)               }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Sequence", USE_VCR do
    before(:each) { hydrate(contract)}

    it "generates one amendment" do
      expect(Amendment.count).to eq(1)
    end
  end
end

# == Schema Information
#
# Table name: amendments
#
#  id            :integer          not null, primary key
#  type          :string
#  sequence      :integer
#  contract_id   :integer
#  contract_uuid :string
#  xfields       :hstore           not null
#  jfields       :jsonb            not null
#  exid          :string
#  uuid          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
