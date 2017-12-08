require 'rails_helper'

RSpec.describe EventLine, type: :model do

  def valid_params
    {
      klas:  "TBD"      ,
      data:  {}
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

end

# == Schema Information
#
# Table name: event_lines
#
#  id         :integer          not null, primary key
#  klas       :string
#  uuref      :string
#  local_hash :string
#  chain_hash :string
#  data       :jsonb            not null
#  jfields    :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
