require 'rails_helper'

RSpec.describe ContractCmd::Cross do

  include_context 'Integration Environment'

  def offer_args(user, alt = {})
    {
      user_uuid:      user.uuid         ,
      stm_issue_uuid: issue.uuid        ,
      maturation:     Time.now - 1.day
    }.merge(alt)
  end

  def gen_offer(usr, type, args = {})
    FB.create(type, offer_args(usr, args)).offer
  end

  let(:issue)  { FB.create(:issue).issue                       }
  let(:obf)    { gen_offer(usr1, :offer_bf)                    }
  let(:obu)    { gen_offer(usr2, :offer_bu)                    }
  let(:klas)   { described_class                               }
  subject      { klas.new(obf, :expand)                        }

  describe "Attributes" do
    it { should respond_to :offer           }
    it { should respond_to :counters        }
    it { should respond_to :type            }
  end

  describe "Object Existence" do
    it { should be_a klas       }
    it { should_not be_valid    }
  end

  describe "expand" do
    it "should work" do
      hydrate(obf, obu)
      expect(Offer.open.count).to eq(2)
      expect(Contract.count).to eq(0)
      expect(subject.valid?).to be(true)
      subject.project
      expect(Offer.open.count).to eq(0)
      expect(Contract.count).to eq(1)
    end
  end

  describe "pricing" do
    it "handles media" do
      o1 = gen_offer(usr1, :offer_bf, {price: 0.1 })
      o2 = gen_offer(usr2, :offer_bu, {price: 0.9 })
      klas.new(o1, :expand).project
      expect(Offer.open.count).to eq(0)
      expect(Contract.count).to eq(1)
    end

    it "handles zero" do
      o1 = gen_offer(usr1, :offer_bf, {price: 0.0 })
      o2 = gen_offer(usr2, :offer_bu, {price: 1.0 })
      klas.new(o1, :expand).project
      expect(Offer.open.count).to eq(0)
      expect(Contract.count).to eq(1)
    end

    it "handles zero" do
      o1 = gen_offer(usr1, :offer_bf, {price: 1.0 })
      o2 = gen_offer(usr2, :offer_bu, {price: 0.0 })
      klas.new(o1, :expand).project
      expect(Offer.open.count).to eq(0)
      expect(Contract.count).to eq(1)
    end
  end
end