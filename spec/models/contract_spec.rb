require 'rails_helper'

RSpec.describe Contract, type: :model do

  def valid_params
    {
      currency_amount: 10
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Attributes" do
    it { should respond_to :exref                  }
    it { should respond_to :uuref                  }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end

    it 'checks for an invalid status label' do
      subject.status = "invalid"
      expect(subject).to_not be_valid
    end
  end

  describe "#uuref" do
    it 'generates a string' do #
      subject.save
      expect(subject.uuref).to be_a(String)
    end

    it 'generates a 36-character string' do
      subject.save
      expect(subject.uuref.length).to eq(36)
    end
  end

  describe "Associations" do
    it { should respond_to(:bug) }
  end

end

# == Schema Information
#
# Table name: contracts
#
#  id              :integer          not null, primary key
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_type   :string
#  currency_amount :float
#  terms           :string
#  status          :string
#  awarded_to      :string
#  expires_at      :datetime
#  repo_id         :integer
#  bug_id          :integer
#  bug_title       :string
#  bug_status      :string
#  bug_labels      :string
#  bug_presence    :boolean
#  jfields         :jsonb            not null
#  exref           :string
#  uuref           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
