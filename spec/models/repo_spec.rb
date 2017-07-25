require 'rails_helper'

RSpec.describe Repo, type: :model do
  def valid_params
    {
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:bugs)         }
    it { should respond_to(:contracts)    }
  end

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
# Table name: repos
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  url        :string
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
