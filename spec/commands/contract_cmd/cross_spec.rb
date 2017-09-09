require 'rails_helper'

RSpec.describe ContractCmd::Cross do

  include_context 'Integration Environment'

  let(:klas)   { described_class                                        }
  subject      { klas.new(ask1.ask)                                     }

  describe "Attributes" do
    it { should respond_to :ask           }
    it { should respond_to :contract      }
    it { should respond_to :cross_list    }
  end

  describe "Object Existence" do
    it { should be_a klas       }
    it { should_not be_valid    }
  end

  describe "Subobjects" do
    it { should respond_to :subobject_symbols }
    it 'returns an array' do
      expect(subject.subobject_symbols).to be_an(Array)
    end
  end

  describe "Delegated Object" do
    before(:each) do hydrate(bid1) end

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
    before(:each) do hydrate(bid1) end

    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(0)
      subject.project #
      expect(Contract.count).to eq(1)
    end

    it 'sets the contract status' do
      subject.project
      expect(subject.status).to eq("open")
    end

    it 'adjusts the user balance' do
      expect(usr1.token_balance).to eq(100)
      subject.project
      usr1.reload
      expect(usr1.token_balance).to eq(80)
    end
  end

  describe "#event_data" do
    it 'returns a hash' do
      expect(subject.event_data).to be_a(Hash)
    end

    # it 'has expected hash keys' do         # TODO: fixme
    #   keys = subject.event_data.keys
    #   expect(keys).to include("uuref")
    # end
  end

  describe "#event_save" do
    it 'creates an event' do
      expect(EventLine.count).to eq(0)
      subject.save_event
      expect(EventLine.count).to eq(5)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(Contract.count).to eq(0)
      subject.save_event.project
      expect(EventLine.count).to eq(5)   # TODO: retest
      expect(Contract.count).to eq(0)
    end
  end
end

