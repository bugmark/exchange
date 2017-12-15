require 'rails_helper'

RSpec.describe UserCmd::Create do

  def valid_params(opts = {})
    {
      "email"    => "asdf@qwer.net"   ,
      "password" => "gggggg"
    }.merge(opts)
  end

  let(:klas)   { described_class                                    }
  subject      { klas.new(valid_params)                             }

  # describe "Object Existence" do
  #   it { should be_a klas   }
  #   it { should be_valid    }
  # end

  describe "#cast" do
    it 'saves the object to the database' do
      subject.cast
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(User.count).to eq(0)
      expect(Event.count).to eq(0)
      subject.cast
      expect(User.count).to eq(1)
      expect(Event.count).to eq(1)
    end

    it 'returns an instance of klas' do
      obj = subject.cast
      expect(obj).to be_a(klas)
    end

    it 'returns an instance of klas' do
      obj = subject.cast
      expect(obj.user).to be_a(User)
    end
  end

  context "with non-zero balance" do
    it "sets the balance" do
      opts = valid_params({"balance" => 250.0})
      obj = klas.new(opts)
      obj.cast
      expect(Event.count).to eq(2)
      expect(User.first.balance).to eq(250.0)
    end
  end
end
