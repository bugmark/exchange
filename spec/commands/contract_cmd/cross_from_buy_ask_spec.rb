require 'rails_helper'

RSpec.describe ContractCmd::CrossFromBuyAsk do

  include_context 'Integration Environment'

  let(:ask)    { FG.create(:buy_ask, user_id: usr1.id).offer         }
  let(:bid)    { FG.create(:buy_bid, user_id: usr2.id).offer         }
  let(:user)   { FG.create(:user).user                               }
  let(:klas)   { described_class                                     }
  subject      { klas.new(ask)                                       }

  describe "Attributes", USE_VCR do
    it { should respond_to :ask           }
    it { should respond_to :contract      }
    it { should respond_to :escrow        }
    it { should respond_to :bid           }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas       }
    it { should_not be_valid    }
  end

  describe "Subobjects", USE_VCR do
    it { should respond_to :subobject_symbols }
    it 'returns an array' do
      expect(subject.subobject_symbols).to be_an(Array)
    end
  end

  describe "Delegated Object", USE_VCR do
    it 'has a present Contract' do
      expect(subject.contract).to be_present
    end

    it 'has a Contract with the right class' do
      expect(subject.contract).to be_a(Contract)
    end
  end

  describe "#project - invalid subject", USE_VCR do
    before(:each) { hydrate(bid) }

    it 'detects an invalid object' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
    end
  end

  describe "#project - valid subject", USE_VCR do
    before(:each) { hydrate(bid) }

    it 'detects a valid object' do
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
      expect(usr1.balance).to eq(100.0)
      expect(usr2.balance).to eq(100.0)
      subject.project
      usr1.reload
      usr2.reload
      expect(usr1.balance).to eq(94.0)
      expect(usr2.balance).to eq(94.0)
    end
  end

  describe "#event_data", USE_VCR do
    it 'returns a hash' do
      expect(subject.event_data).to be_a(Hash)
    end
  end

  describe "#event_save", USE_VCR do
    it 'creates an event' do
      expect(EventLine.count).to eq(0)
      subject.save_event
      expect(EventLine.count).to eq(4)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(Contract.count).to eq(0)
      subject.save_event.project
      expect(EventLine.count).to eq(4)   # TODO: retest
      expect(Contract.count).to eq(0)
    end
  end

  # describe "crossing", USE_VCR do
  #
  #   let(:lcl_ask) { FG.create(:ask, token_value: 10).ask }
  #
  #   context "with single bid" do
  #     it 'matches higher values' do
  #       _bid1 = FG.create(:bid, token_value: 11).bid
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(1)
  #     end
  #
  #     it 'matches equal values' do
  #       _bid1 = FG.create(:bid, token_value: 10).bid
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(1)
  #     end
  #
  #     it 'fails to match lower values' do
  #       _bid1 = FG.create(:bid, token_value: 9).bid
  #       expect(Contract.count).to eq(0)
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(0)
  #     end
  #   end
  #
  #   context "with multiple bids" do
  #     it 'matches higher value' do
  #       _bid1 = FG.create(:bid, token_value: 6).bid
  #       _bid2 = FG.create(:bid, token_value: 6).bid
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(1)
  #     end
  #
  #     it 'matches equal value' do
  #       _bid1 = FG.create(:bid, token_value: 5).bid
  #       _bid2 = FG.create(:bid, token_value: 5).bid
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(1)
  #     end
  #
  #     it 'fails to match lower value' do
  #       _bid1 = FG.create(:bid, token_value: 4).bid
  #       _bid2 = FG.create(:bid, token_value: 4).bid
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(0)
  #     end
  #   end
  #
  #   context "with extra bids" do
  #     it 'does minimal matching' do
  #       _bid1 = FG.create(:bid, token_value: 6).bid
  #       _bid2 = FG.create(:bid, token_value: 6).bid
  #       _bid3 = FG.create(:bid, token_value: 6).bid
  #       klas.new(lcl_ask).project
  #       expect(Contract.count).to eq(1)
  #       expect(Bid.assigned.count).to eq(2)
  #       expect(Bid.unassigned.count).to eq(1)
  #     end
  #   end
  # end
end

