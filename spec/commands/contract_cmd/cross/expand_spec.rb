require 'rails_helper'

RSpec.describe ContractCmd::Cross::Expand do

  include_context 'Integration Environment'

  let(:offer_bf) { FB.create(:offer_bf, user_uuid: usr1.uuid).offer }
  let(:offer_bu) { FB.create(:offer_bu, user_uuid: usr2.uuid).offer }
  let(:user)     { FB.create(:user).user                            }
  let(:klas)     { described_class                                  }
  subject        { klas.new(offer_bf, :expand)                      }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer         }
    it { should respond_to :counters      }
    it { should respond_to :type          }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas       }
    it { should_not be_valid    }
  end

  describe "#project - invalid subject", USE_VCR do
    before(:each) { hydrate(offer_bu) }

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
    before(:each) { hydrate(offer_bu) }

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
      expect(subject.contract.status).to eq("open")
    end

    it 'adjusts the user balance' do
      expect(usr1.balance).to eq(1000.0)
      expect(usr2.balance).to eq(1000.0)
      subject.project
      usr1.reload
      usr2.reload
      expect(usr1.balance).to eq(996.0)
      expect(usr2.balance).to eq(994.0)
    end
  end

  describe "crossing", USE_VCR do
    let(:lcl_offer_bf) { FB.create(:offer_bf).offer }

    context "with single offer_bu" do
      it 'matches higher values' do
        FB.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Position.count).to eq(2)
      end

      it 'generates position ownership' do
        FB.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.first.user_uuid).to_not be_nil
        expect(Position.last.user_uuid).to_not be_nil
      end

      it 'attaches offer to position' do
        FB.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.first.offer_uuid).to_not be_nil
        expect(Position.last.offer_uuid).to_not be_nil
      end

      it 'matches equal values' do
        FB.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower values' do
        FB.create(:offer_bu, price: 0.1, volume: 1)
        expect(Contract.count).to eq(0)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(0)
      end
    end

    context "with multiple offer_bus" do
      it 'matches higher value' do
        _offer_bu1 = FB.create(:offer_bu, price: 0.5, volume: 10).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.5, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(0) #
      end

      it 'matches equal value' do
        _offer_bu1 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower value' do
        _offer_bu1 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end
    end

    context "with extra offer_bus" do
      it 'does minimal matching' do
        _offer_bu1 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Offer.assigned.count).to eq(2)
        expect(Offer.unassigned.count).to eq(2)
      end
    end

    context "with multiple positions" do
      it "generates multiple positions" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.6, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Position.fixed.count).to eq(1)
        expect(Position.unfixed.count).to eq(3)
        expect(Amendment.count).to eq(1)
      end

      it "has compatible volumes on both sides of the escrow" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.6, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Escrow.count).to eq(1)
        expect(Escrow.first.fixed_value).to eq(4.0)
        expect(Escrow.first.unfixed_value).to eq(6.0)
        expect(Escrow.first.total_value).to eq(10.0)
      end
    end

    context "overlapping pricing" do
      it "generates correct prices" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.6, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.fixed.first.price).to eq(0.4)
        expect(Position.unfixed.pluck(:price)).to eq([0.6, 0.6, 0.6])
      end

      it "generates a calculated price" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.7, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.7, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.7, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.fixed.first.price).to eq(0.35)
        expect(Position.unfixed.pluck(:price)).to eq([0.65, 0.65, 0.65])
      end

      it "generates a leveled price" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.7, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.8, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.fixed.first.price).to eq(0.4)
        expect(Position.unfixed.pluck(:price)).to eq([0.6, 0.6, 0.6])
      end

      it "generates a floored price" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.70, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.80, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.75, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.fixed.first.price).to eq(0.35)
        expect(Position.unfixed.pluck(:price)).to eq([0.65, 0.65, 0.65])
      end
    end

    context "with non-overlapping prices" do
      it "fails to generate a cross" do
        _offer_bu1 = FB.create(:offer_bu, price: 0.50, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, price: 0.50, volume: 3).offer
        _offer_bu3 = FB.create(:offer_bu, price: 0.50, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Escrow.count).to eq(0)
      end
    end

    context "with overlapping maturity dates" do
      it "generates a median contract date" do
        _offer_bu1 = FB.create(:offer_bu, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, volume: 3).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.first.maturation).to_not be_nil
      end
    end

    context "with pre-existing contract" do
      it "amends the contract" do
        cdate = Time.now + 1.hour
        _offer_bu1 = FB.create(:offer_bu, volume: 3).offer
        _offer_bu2 = FB.create(:offer_bu, volume: 3).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        Contract.first.update_attribute(:maturation, cdate)
        _offer_bu3 = FB.create(:offer_bu, volume: 3).offer
        offer_bf   = FB.create(:offer_bf, volume: 3).offer
        klas.new(offer_bf, :expand).project
        expect(Contract.count).to eq(2)
        expect(Escrow.count).to eq(2)
      end
    end

    context "with non-overlapping maturity dates" do
      it "fails to generate a cross" do
        beg = Time.now - 2.months
        fin = Time.now - 1.month
        _offer_bu1 = FB.create(:offer_bu, maturation_range: beg..fin)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(0)
        expect(Escrow.count).to eq(0)
        expect(Position.count).to eq(0)
      end
    end

    context "when poolable reserve-limits are exceeded" do
      it "handles the base case" do
        xusr = FB.create(:user, balance: 8.0).user
        _offer_bu1 = FB.create(:offer_bu, volume: 10, user_uuid: xusr.uuid).offer
        expect(xusr.balance).to eq(8.0)
        expect(xusr.token_available).to eq(2.0)
        _offer_bu2 = FB.create(:offer_bu, volume: 10, user_uuid: xusr.uuid)
        expect(xusr.token_available).to eq(2.0)
        klas.new(lcl_offer_bf, :expand).project
        xusr.reload
        expect(Offer.count).to eq(2)
        expect(xusr.balance).to eq(2.0)
        expect(xusr.token_available).to eq(2.0)
      end

      it "suspends over-limit orders", :focus do #
        bugid = FB.create(:gh_issue).issue.uuid
        obf = FB.create(:offer_bf, stm_issue_uuid: bugid).offer
        xusr = FB.create(:user, balance: 8.0).user
        offer_bu1 = FB.create(:offer_bu, stm_issue_uuid: bugid, volume: 10, user_uuid: xusr.uuid, poolable: true)
        expect(offer_bu1).to be_valid
        expect(xusr.balance).to eq(8.0)
        expect(xusr.token_available).to eq(2.0)
        offer_bu2 = FB.create(:offer_bu, stm_issue_uuid: bugid, volume: 10, user_uuid: xusr.uuid, poolable: true)
        expect(offer_bu2).to be_valid
        expect(xusr.token_available).to eq(2.0)
        expect(Offer.count).to eq(3)
        klas.new(obf, :expand).project
        xusr.reload
        expect(Offer.count).to eq(3)
        expect(Offer.suspended.count).to eq(2)
        expect(Offer.crossed.count).to eq(1)
        expect(xusr.balance).to eq(2.0)
        expect(xusr.token_available).to eq(2.0)
      end
    end

    context "when non-poolable reserve-limits are exceeded" do
      it "has nothing to suspend" do
        # TODO: fill this out...
      end
    end

    context "with extra volume" do
      it "generates a re-offer" do
        _offer_bu1 = FB.create(:offer_bu, volume: 100).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Offer.count).to eq(3)
        expect(Contract.count).to eq(1)
      end

      it "makes re-offer with prototype reference" do
        _offer_bu1 = FB.create(:offer_bu, volume: 100).offer
        klas.new(lcl_offer_bf, :expand).project
        reoffer = Offer.where('volume > 50').first
        expect(reoffer.prototype_parent).to_not be_nil
      end

      it "makes re-offer with amendment reference" do
        _offer_bu1 = FB.create(:offer_bu, volume: 100).offer
        klas.new(lcl_offer_bf, :expand).project
        reoffer = Offer.where(volume: 90).first
        expect(reoffer.amendment).to_not be_nil
      end

      it "adjusts the user balance and reserves" do
        offer_bu1 = FB.create(:offer_bu, volume: 100).offer
        usr = offer_bu1.user
        expect(usr.balance).to eq(1000)
        expect(usr.token_available).to eq(940.0)
        klas.new(lcl_offer_bf, :expand).project
        usr.reload
        expect(usr.balance).to eq(994.0)
        expect(usr.token_available).to eq(940.0)
      end
    end

    context "with AON" do
      it "combines matching targets" do
        bugid = FB.create(:gh_issue).issue.uuid
        offer_bf = FB.create(:offer_bf, aon: true, stm_issue_uuid: bugid).offer
        offer_bu = FB.create(:offer_bu, aon: true, stm_issue_uuid: bugid).offer
        klas.new(offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end

      it "doesn't match when AON volume differ" do
        offer_bf = FB.create(:offer_bf, aon: true, volume: 11).offer
        offer_bu = FB.create(:offer_bu, aon: true).offer
        klas.new(offer_bf, :expand).project
        expect(Contract.count).to eq(0)
      end

      it "adjusts the BF offer" do
        bugid    = FB.create(:gh_issue).issue.uuid
        offer_bf = FB.create(:offer_bf, stm_issue_uuid: bugid, volume: 11).offer
        offer_bu = FB.create(:offer_bu, stm_issue_uuid: bugid, aon: true).offer
        klas.new(offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Offer.open.count).to eq(1)  # the re-offer!
      end

      it "does not adjust the BU offer" do
        offer_bf = FB.create(:offer_bf).offer
        offer_bu = FB.create(:offer_bu, volume: 11).offer
        klas.new(offer_bu, :expand).project
        expect(Contract.count).to eq(1)
      end
    end
  end
end

