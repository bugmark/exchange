require 'rails_helper'

RSpec.describe OfferCmd::CreateSell do

  def valid_params(args = {})
    {
      uuid:      SecureRandom.uuid    ,
    }.merge(args)
  end

  let(:user)   { FB.create(:user)                                     }
  let(:bof1)   { FB.create(:offer_bu, user_uuid: user.uuid).offer     }
  let(:pos1)   { FBX.position_u                                       }
  let(:user)   { FB.create(:user).user                                }
  let(:klas)   { described_class                                      }
  subject      { klas.new(pos1, valid_params(volume: 10, price: 0.4)) }

  def gen_osf(opts = {})
    lcl_opts = {price: 0.30}
    klas.new(pos1, lcl_opts.merge(valid_params(opts))).project
  end

  describe "Components", USE_VCR do
    it 'has a position', :focus do
      expect(pos1).to be_present
    end
  end

  describe "Attributes", USE_VCR do
    it { should respond_to :salable_position                   }
    it { should respond_to :offer_new                          }
  end

  describe "Delegated Object", USE_VCR do
    it 'has a present User' do
      expect(subject.offer_new.user).to be_present
    end

    it 'has a User with the right class' do
      expect(subject.offer_new.user).to be_a(User)
    end

    it 'should have a valid User' do
      expect(subject.offer_new.user).to be_valid
    end
  end

  describe "#project", USE_VCR do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Offer.count).to eq(0)
      expect(User.count).to eq(0)
      subject.project
      expect(Offer.is_sell.count).to eq(1)
      expect(Offer.is_buy.count).to eq(2)
      expect(Offer.count).to eq(3)
      expect(User.count).to eq(2)
    end
  end

  describe "price", USE_VCR do
    it "generates a default price" do
      expect(pos1.price).to eq(0.6)
      # noinspection RubyArgCount
      result = subject.project.offer
      expect(result).to be_an(Offer)
      expect(result.price).to eq(0.4)
    end
  end

  describe "balances and reserves", USE_VCR do
    context "basic operation" do
      it "makes no change to the user reserve for sell offer" do
        expect(User.count).to eq(0)
        subject.project
        expect(User.count).to eq(2)
        usr = User.first
        expect(usr.balance).to eq( 994.0)
        expect(usr.token_reserve).to eq(0.0)
      end

      it "has the same maturation date" do
        # noinspection RubyArgCount
        result = subject.project.offer
        expect(result.maturation_range.to_s).to eq(result.salable_position.offer.maturation_range.to_s)
      end

      it "has the same expiration date" do
        # noinspection RubyArgCount
        result = subject.project.offer
        ex1 = result.expiration.strftime("%y%m%d%H%M%S")
        ex2 = result.salable_position.offer.expiration.strftime("%y%m%d%H%M%S")
        expect(ex1).to eq(ex2)
      end
    end

    # context "with poolable offers" do
    #   it "adjusts the user reserve for one offer" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_osf(poolable: true)
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(996.0)
    #   end
    #
    #   it "adjusts the user reserve for many offers" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf(poolable: true) ; gen_obf(poolable: true) ; gen_obf(poolable: true)
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(996.0)
    #   end
    # end

    # context "with non-poolable offers" do
    #   it "adjusts the user reserve for one offer" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf(poolable: false)
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(996.0)
    #   end
    #
    #   it "adjusts the user reserve for many offers" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf(poolable: false) ; gen_obf(poolable: false) ; gen_obf(poolable: false)
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(988.0)
    #   end
    # end

    # context "mixed poolable and non-poolable" do
    #   it "calculates the right reserve" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf(poolable: false) ; gen_obf(poolable: true) ; gen_obf(poolable: true)
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(992.0)
    #   end
    # end
  end

  # describe "balances and limits", USE_VCR do
  #   context "with poolable offers" do
  #     it "stays below balance limit" do
  #       offer1 = gen_obf(volume: 1000, poolable: true)
  #       expect(offer1).to be_valid
  #       offer2 = gen_obf(volume: 1000, poolable: true)
  #       expect(offer2).to be_valid
  #       offer3 = gen_obf(volume: 1000, poolable: true).offer
  #       expect(offer3).to be_valid
  #     end
  #   end
  #
  #   context "with non-poolable offers" do
  #     it "exceeds balance" do
  #       offer1 = gen_obf(volume: 1000, poolable: false)
  #       expect(offer1).to be_truthy
  #       offer2 = gen_obf(volume: 1000, poolable: false)
  #       expect(offer2).to be_truthy
  #       offer3 = gen_obf(volume: 1000, poolable: false)
  #       expect(offer3).to be_falsey
  #     end
  #   end
  # end

  # describe "default values" do
  #   it "has the same price and volume as the salable position"
  #   it "accepts alternative pricing"
  #   it "accepts alternative value"
  # end
  # describe "validation checks" do
  #   it "volume must be less than salable-position volume"
  #   it "sell-offer-user and the position-user must be the same"
  # end
  # describe "user limits"
  # describe "multiple sell offers"
  # describe "offer to sell partial position"
  # describe "matured contract" do
  #   it "new sale offers are not allowed"
  # end
end


