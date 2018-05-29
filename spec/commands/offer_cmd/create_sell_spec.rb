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
      subject.project
      expect(Offer.is_sell.count).to eq(1)
      expect(Offer.is_buy.count).to eq(2)
      expect(Offer.count).to eq(3)
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

  # TODO
  # describe "default values" do
  #   it "has the same price and volume as the salable position"
  #   it "accepts alternative pricing"
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


