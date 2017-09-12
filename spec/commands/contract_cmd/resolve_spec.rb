require 'rails_helper'

RSpec.describe ContractCmd::Resolve, type: :model do

  include_context 'Integration Environment'

  let(:ask)      { ask1.ask                                               }
  let(:contract) { ContractCmd::Cross.new(ask).project.contract           }
  let(:klas)     { described_class                                        }
  subject        { klas.new(contract)                                     }

  describe "Attributes", USE_VCR do
    before(:each) { hydrate(bid1)                  }

    it { should respond_to :contract               }
    it { should respond_to :bids                   }
    it { should respond_to :asks                   }
  end

  describe "Delegated Object", USE_VCR do
    before(:each) { hydrate(bid1)                  }

    it 'has a present Contract' do
      expect(subject.contract).to be_present
    end

    it 'has a Contract with the right class' do
      expect(subject.contract).to be_a(Contract)
    end

    it 'should have a valid Contract' do
      expect(subject.contract).to be_valid
    end
  end

  # TODO: fixme
  # describe "Object Saving" do
  #   it 'saves the object to the database' do
  #     subject.contract_maturation = Time.now - 1.day
  #     subject.project
  #     expect(subject).to be_valid
  #   end
  #
  #   it 'gets the right object count' do
  #     expect(kontrakt).to be_present
  #     expect(Contract.count).to eq(1)
  #     subject.project
  #     expect(Contract.count).to eq(1)
  #   end
  # end

  # TODO: fixme
  # describe "Object Transaction" do
  #   it 'adjusts the user balance' do
  #     expect(user.token_balance).to eq(100)
  #     subject.project
  #     user.reload
  #     expect(user.token_balance).to eq(100)
  #   end
  # end
end
