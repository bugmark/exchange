require 'rails_helper'

RSpec.describe Issue, type: :model do

  def valid_params(tracker, extra_params = {})
    {
      stm_tracker_uuid: tracker.uuid
    }.merge(extra_params)
  end

  let(:klas)   { described_class                            }
  let(:tracker)   { FB.create(:tracker).tracker                      }
  subject      { klas.new(valid_params(tracker))               }

  describe "Attributes", USE_VCR do
    it { should respond_to :exid                  }
    it { should respond_to :uuid                  }
    it { should respond_to :stm_comments          }
  end

  describe "Associations", USE_VCR do
    it { should respond_to(:tracker)         }
    it { should respond_to(:offers)       }
    it { should respond_to(:offers_bf)    }
    it { should respond_to(:offers_bu)    }
  end

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Scopes", USE_VCR do
    it 'has scope methods' do
      expect(klas).to respond_to :base_scope
      expect(klas).to respond_to :by_id
      expect(klas).to respond_to :by_tracker_uuid
      expect(klas).to respond_to :by_title
      expect(klas).to respond_to :by_status
      expect(klas).to respond_to :by_labels
    end
  end

  describe ".match", USE_VCR do
    before(:each) { subject.save}

    it 'matches id' do
      expect(subject).to_not be_nil
      expect(klas.count).to eq(1)
      expect(klas.match({uuid: subject.uuid}).length).to eq(1)
    end
  end

  describe "#uuid", USE_VCR do
    it 'generates a string' do
      subject.save
      expect(subject.uuid).to be_a(String)
    end

    it 'generates a 36-character string' do
      subject.save
      expect(subject.uuid.length).to eq(36)
    end
  end

  describe "stm_issue_uuid", USE_VCR do
    it "starts empty" do
      expect(subject.stm_issue_uuid).to be_nil
    end

    it "fills when saved" do
      subject.save
      expect(subject.stm_issue_uuid).to_not be_nil
      expect(subject.stm_issue_uuid).to eq(subject.uuid)
    end
  end

  describe "#html_url", USE_VCR do
    it { should respond_to :html_url                   }
    it { should respond_to :html_url=                  }

    it "sets the html_url" do
      sub = klas.new(valid_params(tracker, {html_url: "asdf"})) #
      expect(sub.html_url).to eq("asdf")
    end
  end
end

# == Schema Information
#
# Table name: issues
#
#  id               :bigint(8)        not null, primary key
#  type             :string
#  uuid             :string
#  exid             :string
#  sequence         :integer
#  xfields          :hstore           not null
#  jfields          :jsonb            not null
#  synced_at        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stm_issue_uuid   :string
#  stm_tracker_uuid :string
#  stm_title        :string
#  stm_body         :string
#  stm_status       :string
#  stm_labels       :string
#  stm_trader_uuid  :string
#  stm_group_uuid   :string
#  stm_comments     :jsonb            not null
#  stm_jfields      :jsonb            not null
#  stm_xfields      :hstore           not null
#
