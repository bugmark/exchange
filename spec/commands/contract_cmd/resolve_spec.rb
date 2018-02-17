require 'rails_helper'

RSpec.describe ContractCmd::Resolve do

  let(:contract) { FBX.expand.contract                               }
  let(:klas)     { described_class                                   }
  subject        { klas.new(contract)                                }

  describe "Object Existence" do

    # it "works" do
    #   binding.pry
    #   x = 1
    # end

    # it { should be_a klas   }
    # it { should be_valid    }
  end

  describe "#project" do
    # it 'saves the object to the database' do
    #   subject.project
    #   expect(subject).to be_valid
    # end

    # it 'gets the right object count' do
    #   hydrate(contract)
    #   expect(Contract.count).to eq(1)
    #   expect(Event.count).to eq(1)
    #   expect(User.count).to eq(2)
    #   subject.project.contract
    #   expect(Contract.count).to eq(1)
    #   expect(Event.count).to eq(5)
    # end

    # it 'updates the status' do
    #   hydrate(contract)
    #   expect(Contract.count).to eq(1)
    #   expect(Contract.first.status).to eq("open")
    #   contract = klas.new(contract).project.contract
    #   expect(Contract.count).to eq(1)
    #   expect(contract.status).to eq("cancelled")
    # end
  end
end
