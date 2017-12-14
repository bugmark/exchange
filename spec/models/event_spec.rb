require 'rails_helper'

RSpec.describe Event, type: :model do

  def valid_params
    {
      cmd_type:  "TBD"      ,
      data:      {}
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }    #

  describe "Object Creation" do
    it { should be_valid } #

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string
#  uuref        :string
#  cmd_type     :string
#  cmd_id       :string
#  local_hash   :string
#  chain_hash   :string
#  data         :jsonb            not null
#  jfields      :jsonb            not null
#  user_ids     :integer          default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
