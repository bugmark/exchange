require 'rails_helper'

RSpec.describe OfferCmd::CreateBuy do

  def valid_params(args = {})
    {
      user_id: user.id #
    }.merge(args)
  end

  def offer(typ, args = {}) klas.new(typ, valid_params(args)) end

  let(:user)   { FG.create(:user).user                                  }
  let(:klas)   { described_class                                        }
  subject      { klas.new(:offer_bu, valid_params)                      }

  describe "Attributes" do
    it { should respond_to :user                   }
    it { should respond_to :offer                  }
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
    it 'has a present User' do
      expect(subject.user).to be_present
    end

    it 'has a User with the right class' do
      expect(subject.user).to be_a(User)
    end

    it 'should have a valid User' do
      expect(subject.user).to be_valid
    end
  end

  describe "#project" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Offer.count).to eq(0)
      subject.project
      expect(Offer.count).to eq(1)
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
      expect(EventLine.count).to eq(2)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(User.count).to eq(0)
      subject.save_event.project
      expect(EventLine.count).to eq(2)
      expect(Offer.count).to eq(1)
    end
  end
end


