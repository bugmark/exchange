require 'rails_helper'

RSpec.describe Offer::Buy, type: :model do

  def valid_params
    {
      status:  "open"    ,
      user_id: usr.id
    }
  end

  def gen_unfixed(args = {})
    FB.create(:offer_bu, valid_params.merge(args))
  end

  def gen_fixed(args = {})
    FB.create(:offer_bf, valid_params.merge(args))
  end

  let(:usr)    { FB.create(:user, balance: 100.0).user }
  let(:klas)   { described_class                             }
  let(:user)   { FB.create(:user).user                       }
  subject      { klas.new(valid_params)                      }

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Excess Volume", USE_VCR do
    it 'handles the base case' do
      tstbid = gen_unfixed
      expect(tstbid).to be_valid
    end

    it 'detects an invalid balance' do
      tstbid = gen_unfixed(volume: 10000)
      expect(tstbid).to_not be_valid
      msgs = tstbid.errors.messages
      expect(msgs.keys).to include(:volume)
    end
  end

  describe "Invalid Reserve", USE_VCR do
    it "handles the base case" do
      expect(Offer.count).to eq(0)
      tstbid1 = gen_unfixed(price: 0.5, volume: 175)
      expect(tstbid1).to be_valid
    end

    it "handles the overflow case" do
      tstbid1 = gen_unfixed(price: 0.5, volume: 175)
      expect(Offer.count).to eq(1) #
      expect(tstbid1).to be_valid
      tstbid2 = gen_unfixed(price: 0.5, volume: 175)
      expect(tstbid2).to_not be_valid
      expect(Offer.count).to eq(1)
    end
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  type                :string
#  repo_type           :string
#  user_id             :integer
#  prototype_id        :integer
#  amendment_id        :integer
#  reoffer_parent_id   :integer
#  salable_position_id :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  value               :float
#  poolable            :boolean          default(TRUE)
#  aon                 :boolean          default(FALSE)
#  status              :string
#  expiration          :datetime
#  maturation_range    :tsrange
#  xfields             :hstore           not null
#  jfields             :jsonb            not null
#  exid                :string
#  uuid                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  stm_bug_id          :integer
#  stm_repo_id         :integer
#  stm_title           :string
#  stm_status          :string
#  stm_labels          :string
#  stm_xfields         :hstore           not null
#  stm_jfields         :jsonb            not null
#
