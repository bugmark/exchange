require 'rails_helper'

RSpec.describe Offer::Buy::Unfixed, type: :model do
  def valid_params(extras = {})
    {
      user_uuid: user.uuid                                  ,
      maturation_range: BugmTime.now-1.week..BugmTime.now+1.week    ,
      status:  'open'                                       ,
    }.merge(extras)
  end

  def offer3(extras) Offer::Buy::Unfixed.new(valid_params(extras)) end

  let(:user)   { FB.create(:user).user   }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  # describe ".qualified_counteroffers" do
  #   before(:each) do
  #     Offer::Buy::Unfixed.create(valid_params)
  #     Offer::Buy::Fixed.create(valid_params)
  #     Offer::Sell::Unfixed.create(valid_params)
  #     Offer::Sell::Fixed.create(valid_params)
  #   end
  #
  #   describe "#counters" do
  #     before(:each) { subject.save }
  #
  #     it "returns none" do
  #       result = subject.counters(:expand)
  #       expect(result.count).to eq(0)
  #     end
  #
  #     it "returns one with high price" do
  #       obj = offer3(price: 0.9)
  #       result = obj.counters(:expand)
  #       expect(result.count).to eq(1)
  #     end
  #
  #     it "returns zero with low price" do
  #       obj = offer3(price: 0.1)
  #       result = obj.counters(:expand)
  #       expect(result.count).to eq(0)
  #     end
  #   end
  # end
end

# == Schema Information
#
# Table name: offers
#
#  id                    :bigint(8)        not null, primary key
#  uuid                  :string
#  type                  :string
#  tracker_type          :string
#  user_uuid             :string
#  ledger_uuid           :string
#  prototype_uuid        :string
#  amendment_uuid        :string
#  salable_position_uuid :string
#  volume                :integer
#  price                 :float
#  value                 :float
#  poolable              :boolean          default(FALSE)
#  aon                   :boolean          default(FALSE)
#  status                :string
#  expiration            :datetime
#  maturation_range      :tsrange
#  xfields               :hstore           not null
#  jfields               :jsonb            not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  stm_issue_uuid        :string
#  stm_tracker_uuid      :string
#  stm_title             :string
#  stm_body              :string
#  stm_status            :string
#  stm_labels            :string
#  stm_trader_uuid       :string
#  stm_group_uuid        :string
#  stm_currency          :string
#  stm_paypro_uuid       :string
#  stm_comments          :jsonb            not null
#  stm_jfields           :jsonb            not null
#  stm_xfields           :hstore           not null
#
