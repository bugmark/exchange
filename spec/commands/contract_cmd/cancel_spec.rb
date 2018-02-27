require 'rails_helper'

RSpec.describe ContractCmd::Cancel do

  let(:proto) { FB.create(:contract).contract                     }
  let(:klas)  { described_class                                   }
  subject     { klas.new(proto)                                   }

  describe "Object Existence" do
    it { should be_a klas   }
    it { should be_valid    }
  end

  describe "#project" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      hydrate(proto)
      expect(Contract.count).to eq(1)
      subject.project
      expect(Contract.count).to eq(1)
    end

    it 'updates the status' do
      hydrate(proto)
      expect(Contract.count).to eq(1)
      expect(Contract.first.status).to eq("open")
      result = klas.new(proto).project.contract
      expect(Contract.count).to eq(1)
      expect(result.status).to eq("canceled")
    end
  end
end
