require 'rails_helper'

RSpec.describe ContractCmd::Create do

  # TEST FOR
  # - rejection of duplicate contracts
  # - invalid parameters

  def valid_params(alt = {})
    {
      :uuid       => SecureRandom.uuid     ,
      :maturation => BugmTime.now + 1.hour ,
      :type       => "Contract::Test"      ,
      :status     => "open"                ,
    }.merge(alt)
  end

  let(:user)   { FB.create(:user).user      }
  let(:klas)   { described_class            }
  subject      { klas.new(valid_params)     }

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
      expect(Contract.count).to eq(0)
      expect(Event.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
      expect(Event.count).to eq(1)
    end
  end
end
