require 'rails_helper'

RSpec.describe Event::PayproUpdated, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:           "Test::PayproUpdated"      ,
      cmd_uuid:           SecureRandom.uuid          ,
      uuid:               paypro.uuid                ,
      name:               "newname"                  ,
    }.merge(alt)
  end

  let(:paypro) { FB.create(:paypro).paypro  }
  let(:klas)   { described_class            }
  subject      { klas.new(valid_params)     }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :bigint(8)        not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  tags         :string
#  note         :string
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
