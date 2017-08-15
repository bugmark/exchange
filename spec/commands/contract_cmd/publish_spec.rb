require 'rails_helper'

RSpec.describe ContractCmd::Publish, type: :model do

  def valid_params
    {
      token_value:  10            ,
      publisher_id: user.id
    }
  end

  let(:user)   { User.create(email: 'xx@yy.com', password: 'yyyyyy')    }
  let(:klas)   { described_class                                        }
  subject      { klas.new(valid_params)                                 }

  describe "Attributes" do
    it { should respond_to :user                   }
    it { should respond_to :contract               }
    it { should respond_to :token_value            }
  end

  describe "Methods" do
    it { should respond_to :save                 }
  end

  describe "Object Existence" do
    it { should be_a klas   }
    it { should be_valid    }
  end

  describe "Subobjects" do
    it { should respond_to :subobject_symbols }
    it 'returns an array' do
      expect(subject.subobject_symbols).to be_an(Array)
    end
  end

  describe "Delegated Object" do
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

  describe "#project" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
    end

    it 'sets the contract status' do
      subject.project
      expect(subject.status).to eq("open")
    end

    it 'adjusts the user balance' do
      expect(user.token_balance).to eq(100)
      subject.project
      user.reload
      expect(user.token_balance).to eq(90)
    end
  end

  describe "#event_data" do
    it 'returns a hash' do
      expect(subject.event_data).to be_a(Hash)
    end

    it 'has expected hash keys' do
      keys = subject.event_data.keys
      expect(keys).to include("id")
    end
  end

  describe "#event_save" do
    it 'creates an event' do
      expect(EventLine.count).to eq(0)
      subject.save_event
      expect(EventLine.count).to eq(1)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(Contract.count).to eq(0)
      subject.save_event.project
      expect(EventLine.count).to eq(1)
      expect(Contract.count).to eq(1)
    end

    # it 'loads from event' do
    #   expect(EventLine.count).to eq(0)
    #   expect(Contract.count).to eq(0)
    #   subject.save_event
    #   expect(EventLine.count).to eq(1)
    #   klas.from_event(EventLine.first).project
    #   expect(Contract.count).to eq(1)
    # end
  end
end

