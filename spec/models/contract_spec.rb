require 'rails_helper'

RSpec.describe Contract, type: :model do

  include_context 'Integration Environment' #

  def valid_params(opts = {})
    {

    }.merge(opts)
  end

  let(:user) { User.create email: "asdf@qwer.net", password: "gggggg" }
  let(:klas) { described_class                                        }
  subject    { klas.new(valid_params)                                 }

  describe "Associations" do
    it { should respond_to(:escrows)            }
    it { should respond_to(:amendments)         }
  end

  describe "Attributes" do
    it { should respond_to :exid              }
    it { should respond_to :uuid              }
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

  describe "#uuid" do
    it 'holds a string' do
      subject.save
      expect(subject.uuid).to be_a(String)
    end

    it 'holds a 36-character string' do
      subject.save
      expect(subject.uuid.length).to eq(36)
    end
  end

end

# == Schema Information
#
# Table name: contracts
#
#  id             :integer          not null, primary key
#  uuid           :string
#  exid           :string
#  prototype_uuid :integer
#  type           :string
#  status         :string
#  awarded_to     :string
#  maturation     :datetime
#  xfields        :hstore           not null
#  jfields        :jsonb            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  stm_issue_uuid   :string
#  stm_repo_uuid  :string
#  stm_title      :string
#  stm_status     :string
#  stm_labels     :string
#  stm_xfields    :hstore           not null
#  stm_jfields    :jsonb            not null
#
