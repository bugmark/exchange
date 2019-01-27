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

  describe "Object Existence" do
    it { should be_a klas   }
    it { should be_valid    }
  end

  describe "#cmd_cast" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(User.count).to eq(0)
      expect(Event.count).to eq(0)
      subject.project
      expect(User.count).to eq(1)
      expect(Event.count).to eq(1)
    end

    it 'returns an instance of klas' do
      obj = subject.project
      expect(obj).to be_a(klas)
    end

    it 'returns an sub-instance of klas' do
      obj = subject.project
      expect(obj.user).to be_a(User)
    end
  end

  context "with non-zero balance" do
    it "sets the balance" do
      opts = valid_params({"balance" => 250.0})
      obj = klas.new(opts)
      obj.project
      expect(Event.count).to eq(2)
      expect(User.first.balance).to eq(250.0)
    end
  end

  context "with duplicate email" do
    it "fails" do
      obj1 = klas.new(valid_params).project
      obj2 = klas.new(valid_params).project
      expect(obj1.usr1).to be_valid
      expect(obj2.usr1).to_not be_valid
      expect(User.count).to eq(1)
    end
  end

  context "with a negative balance" do
    it "rejects the transaction" do
      opt = valid_params({"balance" => -100.0})
      obj = klas.new(opt)
      obj.project
      expect(obj.user).to_not be_valid
      expect(Event.count).to eq(0)
      expect(User.count).to eq(0)
    end
  end
end
#
