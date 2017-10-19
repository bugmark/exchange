require 'rails_helper'

RSpec.describe Offer::Sell, type: :model do

  def soff_params(user = {})
    {
      parent_position_id: pos1.id
    }
  end

  def position_params(opts = {})
    {
      user_id:      user.id       ,
      buy_offer_id: boff.id       ,
    }.merge(opts)
  end

  let(:user)   { FG.create(:user).user                        }
  let(:pos1)   { Position.new(position_params)                }
  let(:boff)   { FG.create(:buy_bid, user_id: user.id).offer  }
  let(:soff)   { Offer::Sell::Bid.create(soff_params)         }

  let(:klas)   { described_class                              }
  subject      { klas.new(soff_params)                        }

  describe "Associations", USE_VCR do
    it { should respond_to(:parent_position)        }
    it { should respond_to(:transfer)               }
  end

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Associations", USE_VCR do
    before(:each) do hydrate(soff) end

    it "finds the user" do
      binding.pry
      expect(soff.parent_position).to eq(pos1)
    end
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                 :integer          not null, primary key
#  type               :string
#  repo_type          :string
#  user_id            :integer
#  reoffer_parent_id  :integer
#  parent_position_id :integer
#  volume             :integer          default(1)
#  price              :float            default(0.5)
#  poolable           :boolean          default(TRUE)
#  aon                :boolean          default(FALSE)
#  status             :string
#  expiration         :datetime
#  maturation_range   :tsrange
#  jfields            :jsonb            not null
#  exref              :string
#  uuref              :string
#  stm_bug_id         :integer
#  stm_repo_id        :integer
#  stm_title          :string
#  stm_status         :string
#  stm_labels         :string
#  stm_xfields        :hstore           not null
#  stm_jfields        :jsonb            not null
#
