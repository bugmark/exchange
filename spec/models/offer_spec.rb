require 'rails_helper'

RSpec.describe Offer, type: :model do
  def valid_params(extras = {})
    {
      user_uuid: user.uuid                                 ,
      maturation_range: BugmTime.now-1.week..BugmTime.now+1.week   ,
      status:  'open'                                      ,
      volume:  5                                           ,
      price:   0.2
    }.merge(extras)
  end

  let(:offer2) { klas.new(valid_params)  }
  let(:user)   { FB.create(:user).user   }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:user)               }
    it { should respond_to(:issue)                }
    it { should respond_to(:tracker)               }
    it { should respond_to(:position)           }
    it { should respond_to(:amendment)          }
  end

  describe "Attributes" do
    it { should respond_to :exid               }
    it { should respond_to :uuid               }
  end

  describe "Instance Methods" do
    it { should respond_to(:match_issues) }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Scopes" do
    it 'has scope methods' do
      expect(klas).to respond_to :base_scope
      expect(klas).to respond_to :by_id
      expect(klas).to respond_to :by_tracker_uuid
      expect(klas).to respond_to :by_title
      expect(klas).to respond_to :by_status
      expect(klas).to respond_to :by_labels
    end
  end

  describe ".by_id" do
    before(:each) { subject.save}

    it 'returns a matching record' do
      expect(klas.by_id(subject.id).count).to eq(1)
    end
  end

  describe ".match" do
    before(:each) { subject.save}

    it 'matches id' do
      expect(subject).to_not be_nil
      expect(klas.count).to eq(1)
      expect(klas.match({id: subject.id}).length).to eq(1)
    end
  end

  describe ".by_overlap_maturation_range" do
    before(:each) { subject.save }

    it "returns a range search" do
      result = klas.by_overlap_maturation_range(BugmTime.now..BugmTime.now+1.minute)
      expect(result.length).to eq(1)
    end

    it "returns zero when there is a miss" do
      result = klas.by_overlap_maturation_range(BugmTime.now-2.years..BugmTime.now-1.year)
      expect(result.length).to eq(0)
    end
  end

  describe ".by_overlap_maturation" do
    before(:each) { subject.save }

    it "returns a date search" do
      result = klas.by_overlap_maturation(BugmTime.now)
      expect(result.length).to eq(1)
    end

    it "returns zero when there is a miss" do
      result = klas.by_overlap_maturation(BugmTime.now-2.years)
      expect(result.length).to eq(0)
    end
  end

  describe ".open" do
    it "works" do
      subject.save
      expect(Offer.open.count).to eq(1)
      expect(Offer.not_open.count).to eq(0)
    end
  end

  # describe ".is_bid" do
  #   before(:each) do
  #     Offer::Buy::Unfixed.create(valid_params)
  #     Offer::Buy::Fixed.create(valid_params)
  #     Offer::Sell::Unfixed.create(valid_params)
  #     Offer::Sell::Fixed.create(valid_params)
  #   end
  #
  #   it "baselines" do
  #     expect(Offer.count).to eq(4)
  #   end
  #
  #   it "returns bid_side" do
  #     expect(Offer.is_unfixed.count).to eq(2) #
  #   end
  #
  #   it "returns ask_side" do
  #     expect(Offer.is_fixed.count).to eq(2)
  #   end
  #
  #   it "returns buy_intent" do
  #     expect(Offer.is_buy.count).to eq(2)
  #   end
  #
  #   it "returns sell_intent" do
  #     expect(Offer.is_sell.count).to eq(2)
  #   end
  # end

  describe "#overlap_offers" do #.
    before(:each) { subject.save }

    it "returns one with alternate offer", :focus do
      result = offer2.overlap_offers
      expect(result.count).to eq(1)
    end

    it "returns zero with base offer" do
      result = subject.overlap_offers
      expect(result.count).to eq(0)
    end
  end

  describe "#uuid" do
    it 'generates a string' do
      subject.save
      expect(subject.uuid).to be_a(String)
    end

    it 'generates a 36-character string' do
      subject.save
      expect(subject.uuid.length).to eq(36)
    end
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                    :bigint(8)        not null, primary key
#  uuid                  :string
#  exid                  :string
#  type                  :string
#  tracker_type          :string
#  user_uuid             :string
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
#  stm_comments          :jsonb            not null
#  stm_jfields           :jsonb            not null
#  stm_xfields           :hstore           not null
#
