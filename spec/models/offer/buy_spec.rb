require 'rails_helper'

RSpec.describe Offer::Buy, type: :model do

  def valid_params
    {
      status:  "open"    ,
      user_id: usr.id
    }
  end

  def genbid(args = {})
    FG.create(:buy_bid, valid_params.merge(args)).offer
  end

  def genask(args = {})
    FG.create(:buy_ask, valid_params.merge(args)).offer
  end

  let(:usr)    { FG.create(:user, balance: 100.0).user }
  let(:klas)   { described_class                             }
  let(:user)   { FG.create(:user).user                       }
  subject      { klas.new(valid_params)                      }

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid #
    end
  end

  describe "Excess Volume", USE_VCR do
    it 'handles the base case' do
      tstbid = genbid
      expect(tstbid).to be_valid
    end

    it 'detects an invalid balance' do
      tstbid = genbid(volume: 10000)
      expect(tstbid).to_not be_valid
      msgs = tstbid.errors.messages
      expect(msgs.keys).to include(:volume)
    end
  end

  describe "Invalid Reserve", USE_VCR do
    it "handles the base case" do
      expect(Offer.count).to eq(0)
      tstbid1 = genbid(price: 0.5, volume: 175)
      expect(tstbid1).to be_valid
    end

    it "handles the overflow case" do
      tstbid1 = genbid(price: 0.5, volume: 175)
      expect(Offer.count).to eq(1)
      expect(tstbid1).to be_valid
      tstbid2 = genbid(price: 0.5, volume: 175)
      expect(tstbid2).to_not be_valid
      expect(Offer.count).to eq(1)
    end
  end
end

# == Schema Information
#
# Table name: offers
#
#  id               :integer          not null, primary key
#  type             :string
#  repo_type        :string
#  user_id          :integer
#  parent_id        :integer
#  position_id      :integer
#  counter_id       :integer
#  volume           :integer          default(1)
#  price            :float            default(0.5)
#  poolable         :boolean          default(TRUE)
#  aon              :boolean          default(FALSE)
#  status           :string
#  expiration       :datetime
#  maturation       :datetime
#  maturation_range :tsrange
#  jfields          :jsonb            not null
#  exref            :string
#  uuref            :string
#  stm_bug_id       :integer
#  stm_repo_id      :integer
#  stm_title        :string
#  stm_status       :string
#  stm_labels       :string
#  stm_xfields      :hstore           not null
#  stm_jfields      :jsonb            not null
#
