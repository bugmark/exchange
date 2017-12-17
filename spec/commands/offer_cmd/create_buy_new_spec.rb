require 'rails_helper'

RSpec.describe OfferCmd::CreateBuyNew do

  def gen_obf(opts = {})
    lcl_opts = {volume: 10, price: 0.40, user: user}
    klas.new(:offer_bf, lcl_opts.merge(opts)).cast
  end

  def valid_params(args = {})
    {
      user_uuid: user.uuid            ,
      volume:    10                   ,
      price:     0.3
    }.merge(args)
  end

  def offer(typ, args = {}) klas.new(typ, valid_params(args)) end

  let(:user)   { FB.create(:user).user                          }
  let(:klas)   { described_class                                }
  subject      { klas.new(:offer_bu, valid_params)              }

  describe "Attributes" do
    it { should respond_to :user                   }
    it { should respond_to :offer_new              }
    it { should respond_to :offer_event            }
  end

  describe "Object Existence" do
    it { should be_a klas   }
    it { should be_valid    }
  end

  # describe "#project" do
  #   it 'saves the object to the database' do
  #     subject.project
  #     expect(subject).to be_valid
  #   end
  #
  #   it 'gets the right object count' do
  #     expect(Offer.count).to eq(0)
  #     subject.project
  #     expect(Offer.count).to eq(1)
  #   end
  # end

  # describe "creation with a deposit" do
  #   it "generates valid object" do
  #     obj = klas.new(:offer_bu, valid_params(deposit: 2, volume: 20))
  #     expect(obj).to be_valid
  #   end
  #
  #   it "generates price" do
  #     obj = klas.new(:offer_bu, valid_params(deposit: 2, volume: 20))
  #     expect(obj).to be_valid
  #     expect(obj.project.price).to eq(0.1)
  #   end
  #
  #   it "validates deposit" do
  #     obj = klas.new(:offer_bu, valid_params(deposit: 40, volume: 20))
  #     expect(obj).to_not be_valid
  #   end
  # end

  # describe "creation with a profit" do
  #   it "generates valid object" do
  #     obj = klas.new(:offer_bu, valid_params(profit: 2, volume: 20))
  #     expect(obj).to be_valid
  #   end
  #
  #   it "generates price" do
  #     obj = klas.new(:offer_bu, valid_params(profit: 2, volume: 20))
  #     expect(obj).to be_valid
  #     expect(obj.project.price).to eq(0.9)
  #   end
  #
  #   it "validates profit" do
  #     obj = klas.new(:offer_bu, valid_params(profit: 40, volume: 20))
  #     expect(obj).to_not be_valid
  #   end
  # end

  # describe "creation with a maturation" do
  #   it "generates a valid object", :focus do
  #     tst_time = Time.now
  #     obj = klas.new(:offer_bu, valid_params(maturation: tst_time))
  #     expect(obj).to be_valid
  #     expect(obj.maturation.strftime("%H%M%S")).to eq(tst_time.strftime("%H%M%S"))
  #   end
  #
  #   it "generates a valid object from a string", :focus do
  #     tst_date = "17-10-04"
  #     obj = klas.new(:offer_bu, valid_params(maturation: tst_date))
  #     expect(obj).to be_valid
  #     expect(obj.maturation.strftime("%y-%m-%d")).to eq(tst_date)
  #   end
  # end

  describe "balances and reserves", USE_VCR do
    # context "with poolable offers" do
    #   it "adjusts the user reserve for one offer" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(996.0)
    #   end
    #
    #   it "adjusts the user reserve for many offers" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf ; gen_obf ; gen_obf
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(996.0)
    #   end
    # end

    context "with non-poolable offers" do
      # it "adjusts the user reserve for one offer" do
      #   expect(user.balance).to eq(1000.0)
      #   expect(user.token_available).to eq(1000.0)
      #   gen_obf(poolable: false)
      #   expect(user.balance).to eq(1000.0)
      #   expect(user.token_available).to eq(996.0)
      # end

      # it "adjusts the user reserve for many offers" do
      #   expect(user.balance).to eq(1000.0)
      #   expect(user.token_available).to eq(1000.0)
      #   gen_obf(poolable: false) ; gen_obf(poolable: false) ; gen_obf(poolable: false)
      #   expect(user.balance).to eq(1000.0)
      #   expect(user.token_available).to eq(988.0)
      # end
    end

    # context "mixed poolable and non-poolable" do
    #   it "calculates the right reserve" do
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(1000.0)
    #     gen_obf(poolable: false) ; gen_obf ; gen_obf
    #     expect(user.balance).to eq(1000.0)
    #     expect(user.token_available).to eq(992.0)
    #   end
    # end
  end

  describe "balances and limits", USE_VCR do
    # context "with poolable offers" do
    #   it "stays below balance limit" do
    #     offer1 = gen_obf(volume: 1000)
    #     expect(offer1).to be_valid
    #     offer2 = gen_obf(volume: 1000)
    #     expect(offer2).to be_valid
    #     offer3 = gen_obf(volume: 1000)
    #     expect(offer3).to be_valid
    #   end
    # end

    # context "with non-poolable offers" do
    #   it "exceeds balance" do
    #     offer1 = gen_obf(volume: 1000, poolable: false)
    #     expect(offer1).to be_truthy
    #     offer2 = gen_obf(volume: 1000, poolable: false)
    #     expect(offer2).to be_truthy
    #     offer3 = gen_obf(volume: 1000, poolable: false)
    #     expect(offer3).to be_falsey
    #   end
    # end
  end
end
