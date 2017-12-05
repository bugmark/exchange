require 'rails_helper'

RSpec.describe Escrow, type: :model do
  def valid_params(opt = {})
    {
      amendment_id: 1,
      type:         "Escrow::Expand"
    }.merge(opt)
  end

  def gen_escrow(opts = {}) klas.create(valid_params(opts)) end

  let(:contract) { FBX.expand_obf.contract    }
  let(:klas)     { described_class            }
  subject        { klas.new(valid_params)     }

  describe "Associations" do
    it { should respond_to(:contract)               }
    it { should respond_to(:positions)              }
    it { should respond_to(:fixed_positions)        }
    it { should respond_to(:unfixed_positions)      }
    it { should respond_to(:amendment)              }
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

    it "generates one escrow" do
      expect(Escrow.count).to eq(1)
    end
  end
end

# == Schema Information
#
# Table name: escrows
#
#  id            :integer          not null, primary key
#  type          :string
#  sequence      :integer
#  contract_id   :integer
#  amendment_id  :integer
#  fixed_value   :float            default(0.0)
#  unfixed_value :float            default(0.0)
#  exref         :string
#  uuref         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
