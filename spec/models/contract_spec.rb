require 'rails_helper'

RSpec.describe Contract, type: :model do

  include_context 'Integration Environment'

  def valid_params
    {
    }
  end

  let(:user) { User.create email: "asdf@qwer.net", password: "gggggg" }
  let(:klas) { described_class                                        }
  subject    { klas.new(valid_params)                                 }

  describe "Associations" do
    it { should respond_to(:repo)              }
    it { should respond_to(:bug)               }
    it { should respond_to(:bids)              }
    it { should respond_to(:asks)              }
  end

  describe "Attributes" do
    it { should respond_to :exref              }
    it { should respond_to :uuref              }
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
    it 'holds a string' do
      subject.save
      expect(subject.uuref).to be_a(String)
    end

    it 'holds a 36-character string' do
      subject.save
      expect(subject.uuref.length).to eq(36)
    end
  end

end

# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  type                :string
#  mode                :string
#  status              :string
#  awarded_to          :string
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
