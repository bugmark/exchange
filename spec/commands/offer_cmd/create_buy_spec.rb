require 'rails_helper'

RSpec.describe OfferCmd::CreateBuy do

  def gen_obf(opts = {})
    lcl_opts = {volume: 10, price: 0.40, user: user}
    klas.new(:offer_bf, lcl_opts.merge(opts)).project
  end

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
    it { should respond_to :stake                  }
    it { should respond_to :volume                 }
    it { should respond_to :price                  }
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

  describe "creation with a stake" do
    it "generates valid object" do
      obj = klas.new(:offer_bu, valid_params(stake: 2, volume: 20))
      expect(obj).to be_valid
    end

    it "generates price" do
      obj = klas.new(:offer_bu, valid_params(stake: 2, volume: 20))
      expect(obj).to be_valid
      expect(obj.project.price).to eq(0.1)
    end

    it "validates stake" do
      obj = klas.new(:offer_bu, valid_params(stake: 40, volume: 20))
      expect(obj).to_not be_valid
    end
  end

  describe "balances and reserves", USE_VCR do
    context "with poolable offers", focus: true do
      it "adjusts the user reserve for one offer" do
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(100.0)
        gen_obf
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(96.0)
      end

      it "adjusts the user reserve for many offers" do
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(100.0)
        gen_obf ; gen_obf ; gen_obf
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(96.0)
      end
    end

    context "with non-poolable offers", focus: true do
      it "adjusts the user reserve for one offer" do
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(100.0)
        gen_obf(poolable: false)
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(96.0)
      end

      it "adjusts the user reserve for many offers" do
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(100.0)
        gen_obf(poolable: false) ; gen_obf(poolable: false) ; gen_obf(poolable: false)
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(88.0)
      end
    end

    context "mixed poolable and non-poolable", focus: true do
      it "calculates the right reserve" do
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(100.0)
        gen_obf(poolable: false) ; gen_obf ; gen_obf
        expect(user.balance).to eq(100.0)
        expect(user.token_available).to eq(92.0)
      end
    end
  end

  describe "balances and limits", USE_VCR do
    context "with poolable offers", focus: true do
      it "stays below balance limit" do
        offer1 = gen_obf(volume: 100)
        expect(offer1).to be_valid
        offer2 = gen_obf(volume: 100)
        expect(offer2).to be_valid
        offer3 = gen_obf(volume: 100)
        expect(offer3).to be_valid
      end
    end

    context "with non-poolable offers", focus: true do
      it "exceeds balance", focus: true do
        offer1 = gen_obf(volume: 100, poolable: false)
        expect(offer1).to be_truthy
        offer2 = gen_obf(volume: 100, poolable: false)
        expect(offer2).to be_truthy
        offer3 = gen_obf(volume: 100, poolable: false)
        expect(offer3).to be_falsey
      end
    end
  end
end
