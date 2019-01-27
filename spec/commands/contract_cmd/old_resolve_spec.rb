require 'rails_helper'

RSpec.describe ContractCmd::Resolve, type: :model do

  include_context 'FactoryBot'

  let(:contract) { FBX.expand_obf.contract                                }
  let(:klas)     { described_class                                        }
  subject        { klas.new(contract)                                     }

  # describe "Attributes", USE_VCR do
  #
  #   it { should respond_to :contract               }
  # end
  #
  # describe "Delegated Object", USE_VCR do
  #   it 'has a present Contract' do
  #     expect(subject.contract).to be_present
  #   end
  #
  #   it 'has a Contract with the right class' do
  #     expect(subject.contract).to be_a(Contract)
  #   end
  #
  #   it 'should have a valid Contract' do
  #     expect(subject.contract).to be_valid
  #   end
  # end
  #
  # describe "Object Saving", USE_VCR do
  #   it 'saves the object to the database' do
  #     subject.maturation = Time.now - 1.day
  #     subject.project
  #     expect(subject).to be_valid
  #   end
  #
  #   it 'gets the right object count' do
  #     expect(contract).to be_present
  #     expect(Contract.count).to eq(1)
  #     subject.project
  #     expect(Contract.count).to eq(1)
  #   end
  # end
  #
  # describe "Object Transaction", USE_VCR do
  #   it 'adjusts the user balance' do
  #     expect(usr4.balance).to eq(1000)
  #     subject.project
  #     usr4.reload
  #     expect(usr4.balance).to eq(1000)
  #   end
  # end

  # describe "side effects" do
  #   it "closes all open sell offers"
  # end
end
