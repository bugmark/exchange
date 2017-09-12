require 'rails_helper'

RSpec.describe ContractCmd::Cross do #.

  include_context 'Integration Environment'

  let(:klas)   { described_class                                        }
  subject      { klas.new(ask1.ask)                                     }

  describe "Attributes", USE_VCR do
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
      subject.project
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
  end

  describe "#event_save" do #.
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

  describe "crossing" do

    let(:lcl_ask) { FG.create(:ask, token_value: 10).ask }

    context "with single bid" do
      it 'matches higher values' do
        _bid1 = FG.create(:bid, token_value: 11).bid
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(1)
      end

      it 'matches equal values' do
        _bid1 = FG.create(:bid, token_value: 10).bid
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower values' do
        _bid1 = FG.create(:bid, token_value: 9).bid
        expect(Contract.count).to eq(0)
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(0)
      end
    end

    context "with multiple bids" do
      it 'matches higher value' do
        _bid1 = FG.create(:bid, token_value: 6).bid
        _bid2 = FG.create(:bid, token_value: 6).bid
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(1)
      end

      it 'matches equal value' do
        _bid1 = FG.create(:bid, token_value: 5).bid
        _bid2 = FG.create(:bid, token_value: 5).bid
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower value' do
        _bid1 = FG.create(:bid, token_value: 4).bid
        _bid2 = FG.create(:bid, token_value: 4).bid
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(0)
      end
    end

    context "with extra bids" do
      it 'does minimal matching' do
        _bid1 = FG.create(:bid, token_value: 6).bid
        _bid2 = FG.create(:bid, token_value: 6).bid
        _bid3 = FG.create(:bid, token_value: 6).bid
        klas.new(lcl_ask).project
        expect(Contract.count).to eq(1)
        expect(Bid.assigned.count).to eq(2)
        expect(Bid.unassigned.count).to eq(1)
      end
    end
  end
end

