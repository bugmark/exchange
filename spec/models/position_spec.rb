require 'rails_helper'

RSpec.describe Position, type: :model do #
  def valid_params(opts = {})
    {
      user_uuid:  user.uuid       ,
      offer_uuid: boff.uuid
    }.merge(opts)
  end

  let(:klas)    { described_class                                  }
  subject       { klas.new(valid_params)                           }

  let(:user)    { FB.create(:user).user                            }
  let(:boff)    { FB.create(:offer_bu, user_uuid: user.uuid).offer }
  let(:pos1)    { klas.new(valid_params)                           }

  describe "Associations", USE_VCR do
    it { should respond_to(:offer)                }
    it { should respond_to(:offers_sell)          }
    it { should respond_to(:parent)               }
    it { should respond_to(:children)             }
    it { should respond_to(:user)                 }
    it { should respond_to(:escrow)               }
    it { should respond_to(:amendment)            }
  end

  describe "Object Creation", USE_VCR do
    # it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Associations", USE_VCR do
    before(:each) do hydrate(pos1) end

    it "finds the user" do
      expect(pos1.user).to eq(user)
    end

    it "finds the offer" do
      expect(pos1.offer).to eq(boff)
    end
  end
end

# == Schema Information
#
# Table name: positions
#
#  id             :integer          not null, primary key
#  offer_id       :integer
#  offer_uuid     :string
#  user_id        :integer
#  user_uuid      :string
#  amendment_id   :integer
#  amendment_uuid :string
#  escrow_id      :integer
#  escrow_uuid    :string
#  parent_id      :integer
#  parent_uuid    :string
#  volume         :integer
#  price          :float
#  value          :float
#  side           :string
#  exid           :string
#  uuid           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
