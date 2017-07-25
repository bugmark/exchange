require 'rails_helper'

RSpec.describe Bug, type: :model do

  def valid_params(repo)
    {
      repo_id: repo.id
    }
  end

  let(:klas)   { described_class                      }
  subject      { klas.new(valid_params(Repo.create))  }

  describe "Associations" do
    it { should respond_to(:repo)         }
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
# Table name: bugs
#
#  id          :integer          not null, primary key
#  repo_id     :integer
#  type        :string
#  api_url     :string
#  http_url    :string
#  title       :string
#  description :string
#  status      :string
#  labels      :text             default([]), is an Array
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
