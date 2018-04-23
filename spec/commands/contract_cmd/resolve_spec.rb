require 'rails_helper'

RSpec.describe ContractCmd::Resolve do

  include_context 'Integration Environment'

  def offer_args(user, alt = {})
    {
      user_uuid:      user.uuid         ,
      stm_issue_uuid: issue.uuid        ,
      maturation:     BugmTime.now - 1.day
    }.merge(alt)
  end

  def gen_offer(usr, type, args = {})
    FB.create(type, offer_args(usr, args)).offer
  end

  let(:issue)    { FB.create(:issue).issue                               }
  let(:obf)      { gen_offer(usr1, :offer_bf)                            }
  let(:obu)      { gen_offer(usr2, :offer_bu)                            }
  let(:contract) { ContractCmd::Cross.new(obf, :expand).project.contract }
  let(:klas)     { described_class                                       }
  subject        { klas.new(contract)                                    }

  describe "project" do
    it "has a valid command" do
      hydrate(issue, obf, obu)
      expect(subject).to be_valid
    end

    it "runs w/o error" do
      hydrate(issue, obf, obu)
      expect(subject.project).to_not be_nil
    end

    it "has the right setup counts" do
      hydrate(issue, obf, obu)
      expect(Offer.open.count).to eq(2)
      expect(Contract.count).to eq(0)
      hydrate(contract)
      expect(Offer.open.count).to eq(0)
      expect(Contract.count).to eq(1)
    end

    it "has the right user balances" do
      hydrate(issue, obf, obu, contract)
      expect(User.first.balance).to eq(996.0)
      expect(User.last.balance).to eq(994.0)
      subject.project
      expect(User.first.balance).to eq(996.0)
      expect(User.last.balance).to eq(1004.0)
    end
  end

  describe "pricing" do
    it "handles median price" do
      o1 = gen_offer(usr1, :offer_bf, {price: 0.1 })
      o2 = gen_offer(usr2, :offer_bu, {price: 0.9 })
      ct = ContractCmd::Cross.new(o1, :expand).project.contract
      expect(User.first.balance).to eq(999.0)
      expect(User.last.balance).to  eq(991.0)
      cmd = klas.new(ct)
      expect(cmd).to be_valid
      cmd.project
      expect(User.first.balance).to eq( 999.0)
      expect(User.last.balance).to  eq(1001.0)
    end

    it "handles median price" do
      o1 = gen_offer(usr1, :offer_bf, {price: 0.9 })
      o2 = gen_offer(usr2, :offer_bu, {price: 0.1 })
      ct = ContractCmd::Cross.new(o1, :expand).project.contract
      expect(User.first.balance).to eq(991.0)
      expect(User.last.balance).to  eq(999.0)
      cmd = klas.new(ct)
      expect(cmd).to be_valid
      cmd.project
      expect(User.first.balance).to eq( 991.0)
      expect(User.last.balance).to  eq(1009.0)
    end

    it "handles zero price" do
      o1 = gen_offer(usr1, :offer_bf, {price: 0.0 })
      o2 = gen_offer(usr2, :offer_bu, {price: 1.0 })
      ct = ContractCmd::Cross.new(o1, :expand).project.contract
      expect(User.first.balance).to eq(1000.0)
      expect(User.last.balance).to  eq( 990.0)
      klas.new(ct).project
      expect(User.first.balance).to eq(1000.0)
      expect(User.last.balance).to  eq(1000.0)
    end

    it "handles 1.0 price" do
      o1 = gen_offer(usr1, :offer_bf, {price: 1.0 })
      o2 = gen_offer(usr2, :offer_bu, {price: 0.0 })
      ct = ContractCmd::Cross.new(o1, :expand).project.contract
      expect(User.first.balance).to eq( 990.0)
      expect(User.last.balance).to  eq(1000.0)
      cmd = klas.new(ct)
      expect(cmd).to be_valid
      cmd.project
      expect(User.first.balance).to eq( 990.0)
      expect(User.last.balance).to  eq(1010.0)
    end
  end
end
