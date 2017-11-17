require 'rails_helper'

RSpec.describe Offer::Buy::Unfixed, type: :model do
  def valid_params(extras = {})
    {
      user_id: user.id                                      ,
      maturation_range: Time.now-1.week..Time.now+1.week    ,
      status:  'open'                                     ,
    }.merge(extras)
  end

  def offer3(extras) Offer::Buy::Unfixed.new(valid_params(extras)) end

  let(:user)   { FG.create(:user)        }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe ".qualified_counteroffers" do
    before(:each) do
      Offer::Buy::Unfixed.create(valid_params)
      Offer::Buy::Fixed.create(valid_params)
      Offer::Sell::Unfixed.create(valid_params)
      Offer::Sell::Fixed.create(valid_params)
    end

    describe "#counters" do
      before(:each) { subject.save }

      it "returns none" do
        result = subject.counters(:expand)
        expect(result.count).to eq(0)
      end

      it "returns one with high price" do
        obj = offer3(price: 0.9)
        result = obj.counters(:expand)
        expect(result.count).to eq(1)
      end

      it "returns zero with low price" do
        obj = offer3(price: 0.1)
        result = obj.counters(:expand)
        expect(result.count).to eq(0)
      end
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
#  prototype_id       :integer
#  amendment_id       :integer
#  reoffer_parent_id  :integer
#  parent_position_id :integer
#  volume             :integer          default(1)
#  price              :float            default(0.5)
#  poolable           :boolean          default(TRUE)
#  aon                :boolean          default(FALSE)
#  status             :string
#  expiration         :datetime
#  maturation_range   :tsrange
#  xfields            :hstore           not null
#  jfields            :jsonb            not null
#  exref              :string
#  uuref              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  stm_bug_id         :integer
#  stm_repo_id        :integer
#  stm_title          :string
#  stm_status         :string
#  stm_labels         :string
#  stm_xfields        :hstore           not null
#  stm_jfields        :jsonb            not null
#
