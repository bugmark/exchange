require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_params
    {email: "asdf@qwer.net", password: "gggggg"}
  end

  def genbid(args = {})
    FG.create(:buy_bid, {user_id: usr.id}.merge(args))
  end

  def genask(args = {})
    FG.create(:buy_ask, {user_id: usr.id}.merge(args))
  end

  let(:usr) { FG.create(:user, token_balance: 100.0).user }
  let(:ask) { FG.create(:buy_ask, user_id: user.id) }
  let(:klas) { described_class }
  subject { klas.new(valid_params) }

  describe "Associations" do
    it { should respond_to(:buy_offers) }
    it { should respond_to(:bids) }
    it { should respond_to(:asks) }
    it { should respond_to(:sell_offers) }
    it { should respond_to(:published_contracts) }
    it { should respond_to(:taken_contracts) }
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
      expect(usr.bids).to eq([])
    end

    it 'returns a bid if one exists' do
      genbid
      expect(usr.offers.count).to eq(1)
      expect(usr.buy_offers.count).to eq(1)
      expect(usr.bids.count).to eq(1)
      expect(usr.asks.count).to eq(0)
    end

    it 'handles bids and asks' do
      genbid; genask
      expect(usr.offers.count).to eq(2)
      expect(usr.buy_offers.count).to eq(2)
      expect(usr.bids.count).to eq(1)
      expect(usr.asks.count).to eq(1)
    end
  end

  describe "token_balance" do
    it "is a float" do
      expect(subject.token_balance).to be_a(Float)
    end

    it "has a default value" do
      expect(usr.token_balance).to eq(100.0)
    end
  end

  describe "#token_reserve_poolable", USE_VCR do
    it "has a value with one bid" do
      genbid
      expect(usr.token_reserve_poolable).to eq(2.0)
    end

    it "has a value with two bids" do
      genbid; genbid
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_poolable).to eq(2.0)
    end

    it "has a value with one ask" do
      genask
      expect(usr.token_reserve_poolable).to eq(4.0)
    end

    it "has a value with two asks" do
      genask; genask
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_poolable).to eq(4.0)
    end

    it "has a value with a bid and an ask" do
      genbid; genask
      expect(Offer::Buy::Bid.count).to eq(1)
      expect(Offer::Buy::Ask.count).to eq(1)
      expect(usr.token_reserve_poolable).to eq(4.0)
    end
  end

  describe "#token_reserve_not_poolable", USE_VCR do
    it "has a value with one bid" do
      genbid(poolable: false)
      expect(usr.token_reserve_not_poolable).to eq(2.0)
    end

    it "has a value with two bids" do
      genbid(poolable: false); genbid(poolable: false)
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_not_poolable).to eq(4.0)
    end

    it "has a value with one ask" do
      genask(poolable: false)
      expect(usr.token_reserve_not_poolable).to eq(4.0)
    end

    it "has a value with two asks" do
      genask(poolable: false); genask(poolable: false)
      expect(Offer.count).to eq(2)
      expect(usr.token_reserve_not_poolable).to eq(8.0)
    end

    it "has a value with a bid and an ask" do
      genbid(poolable: false); genask(poolable: false)
      expect(Offer::Buy::Bid.count).to eq(1)
      expect(Offer::Buy::Ask.count).to eq(1)
      expect(usr.token_reserve_not_poolable).to eq(6.0)
    end
  end

  describe "#token_available", USE_VCR do
    it "has a value with one bid" do
      genbid(poolable: false)
      expect(usr.token_available).to eq(98.0)
    end

    it "has a value with two bids" do
      genbid(poolable: false); genbid(poolable: false)
      expect(Offer.count).to eq(2)
      expect(usr.token_available).to eq(96.0)
    end

    it "has a value with one ask" do
      genask(poolable: false)
      expect(usr.token_available).to eq(96.0)
    end

    it "has a value with two asks" do
      genask(poolable: false); genask
      expect(Offer.count).to eq(2)
      expect(usr.token_available).to eq(92.0)
    end

    it "has a value with a bid and an ask" do
      genbid; genask(poolable: false)
      expect(Offer::Buy::Bid.count).to eq(1)
      expect(Offer::Buy::Ask.count).to eq(1)
      expect(usr.token_available).to eq(94.0)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean
#  token_balance          :float            default(0.0)
#  exref                  :string
#  uuref                  :string
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
