require 'rails_helper'

RSpec.describe Repo, :type => :model do
  def valid_params
    {
      name:     "asdf/qwer"
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:bugs)         }
    # it { should respond_to(:contracts)    }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Data Sync" do
    it 'records a GitHub Api interaction' do
      VCR.use_cassette 'model/repo' do
        response = Octokit.repo 'mvscorg/bugmark'
        expect(response).to_not be_nil
      end
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
#  xfields    :hstore           not null
#  jfields    :jsonb            not null
#  synced_at  :datetime
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
