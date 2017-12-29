require 'rails_helper'

RSpec.describe User, type: :model do #
  def valid_params
    {email: "asdf@qwer.net", password: "gggggg"}
  end

  def gen_unfixed(args = {})
    FB.create(:offer_bu, {user_uuid: usr.uuid}.merge(args))
  end

  def gen_fixed(args = {})
    FB.create(:offer_bf, {user_uuid: usr.uuid}.merge(args))
  end

  let(:usr)  { FB.create(:user, balance: 100.0).user       }
  let(:ask)  { FB.create(:offer_bf, user_id: user.id)      }
  let(:klas) { described_class }
  subject { klas.new(valid_params) }

  describe "Associations" do
    it { should respond_to(:offers_buy)  }
    it { should respond_to(:offers_bu)   }
    it { should respond_to(:offers_bf)   }
    it { should respond_to(:offers_sell) }
    it { should respond_to(:offers_sf)   }
    it { should respond_to(:offers_su)   }
    it { should respond_to(:contracts)   }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Offer Associations", USE_VCR do
    it 'starts with no bids' do
      expect(usr.offers).to eq([])
    end

    it 'returns a offer if one exists', :focus do
      gen_unfixed
      expect(usr.offers.count).to     eq(1)
      expect(usr.offers_buy.count).to eq(1)
      expect(usr.offers_bu.count).to  eq(1)
      expect(usr.offers_bf.count).to  eq(0)
    end

    it 'handles offers_bf and offers_bu' do
      gen_unfixed; gen_fixed
      expect(usr.offers.count).to eq(2)
      expect(usr.offers_buy.count).to eq(2)
      expect(usr.offers_bf.count).to eq(1)
      expect(usr.offers_bu.count).to eq(1)
    end
  end

  describe "balance" do
    it "is a float" do
      expect(subject.balance).to be_a(Float)
    end

    it "has a default value" do
      hydrate usr
      expect(usr.balance).to eq(100.0)
    end
  end

  describe "#token_reserve_poolable", USE_VCR do #
    it "has a value with one bid" do
      gen_unfixed(poolable: true)
      expect(usr.token_reserve_poolable).to eq(6.0)
    end

    it "has a value with two bids" do
      gen_unfixed(poolable: true); gen_unfixed(poolable: true)
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_poolable).to eq(6.0)
    end

    it "has a value with one ask" do
      gen_fixed(poolable: true)
      expect(usr.token_reserve_poolable).to eq(4.0)
    end

    it "has a value with two asks" do
      gen_fixed(poolable: true); gen_fixed(poolable: true)
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_poolable).to eq(4.0)
    end

    it "has a value with a bid and an ask" do
      gen_unfixed(poolable: true); gen_fixed(poolable: true)
      expect(Offer::Buy::Unfixed.count).to eq(1)
      expect(Offer::Buy::Fixed.count).to eq(1)
      expect(usr.token_reserve_poolable).to eq(6.0)
    end
  end

  describe "#token_reserve_not_poolable", USE_VCR do
    it "has a value with one bid" do
      gen_unfixed(poolable: false)
      expect(usr.token_reserve_not_poolable).to eq(6.0)
    end

    it "has a value with two bids" do
      gen_unfixed(poolable: false); gen_unfixed(poolable: false)
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_not_poolable).to eq(12.0)
    end

    it "has a value with one ask" do
      gen_fixed(poolable: false)
      expect(usr.token_reserve_not_poolable).to eq(4.0)
    end

    it "has a value with two asks" do
      gen_fixed(poolable: false); gen_fixed(poolable: false)
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_not_poolable).to eq(8.0)
    end

    it "has a value with a bid and an ask" do
      gen_unfixed(poolable: false); gen_fixed(poolable: false)
      expect(Offer::Buy::Unfixed.count).to eq(1)
      expect(Offer::Buy::Fixed.count).to eq(1)
      expect(usr.token_reserve_not_poolable).to eq(10.0)
    end
  end

  describe "#token_available", USE_VCR do
    it "has a value with one bid" do
      gen_unfixed(poolable: false)
      expect(usr.token_available).to eq(94.0)
    end

    it "has a value with two bids" do
      gen_unfixed(poolable: false); gen_unfixed(poolable: false)
      expect(Offer.count).to eq(2)
      expect(usr.token_available).to eq(88.0)
    end

    it "has a value with one ask" do
      gen_fixed(poolable: false)
      expect(usr.token_available).to eq(96.0)
    end

    it "has a value with two asks" do
      gen_fixed(poolable: false)
      gen_fixed
      expect(Offer.count).to eq(2)
      expect(usr.token_available).to eq(92.0)
    end

    it "has a value with a bid and an ask" do
      gen_unfixed; gen_fixed(poolable: false)
      expect(Offer::Buy::Unfixed.count).to eq(1)
      expect(Offer::Buy::Fixed.count).to eq(1)
      expect(usr.token_available).to eq(90.0)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  uuid                   :string
#  exid                   :string
#  admin                  :boolean
#  balance                :float            default(0.0)
#  jfields                :jsonb            not null
#  last_seen_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#
