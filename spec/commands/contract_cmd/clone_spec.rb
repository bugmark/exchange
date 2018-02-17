require 'rails_helper'
require 'ext/hash'

RSpec.describe ContractCmd::Clone do

  # TEST FOR
  # - rejection of duplicate contracts
  # - invalid parameters
  #
  def valid_params(args = {})
    {

    }.merge(args).without_blanks
  end

  let(:proto) { FB.create(:contract).contract                     }
  let(:klas)  { described_class                                   }
  subject     { klas.new(proto, valid_params)                     }

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
      expect(Contract.count).to eq(2)
    end

    it 'updates the clone params' do
      hydrate(proto)
      expect(Contract.count).to eq(1)
      result = klas.new(proto, title: "NEW").project
      expect(Contract.count).to eq(2)
      expect(result.clone.stm_title).to eq("NEW")
    end
  end
end
