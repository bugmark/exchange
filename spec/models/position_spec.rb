require 'rails_helper'

RSpec.describe Position, type: :model do
  def valid_params(opts = {})
    {}.merge(opts)
  end

  include_context 'Integration Environment'

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:buy_offer)            }
    it { should respond_to(:sell_offers)          }
    # it { should respond_to(:parent)               }
    # it { should respond_to(:children)             }
  end

  describe "Object Creation" do
    # it { should be_valid }

    # it 'saves the object to the database' do
    #   subject.save
    #   expect(subject).to be_valid
    # end
  end

  describe "Buy Offers" do
    before(:each) do
      hydrate(usr1)
      # ding = FG.create(:buy_bid)
      # poz1 = klas.create(offer_id: buy_buy.id, volume: bid_buy.volume, price: bid_buy.price)
    end

    it "bings", USE_VCR do
      # binding.pry
      expect(1).to eq(1) #..
    end
  end
end

# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  offer_id   :integer
#  user_id    :integer
#  escrow_id  :integer
#  parent_id  :integer
#  volume     :integer
#  price      :float
#  side       :string
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
