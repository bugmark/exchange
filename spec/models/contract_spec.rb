require 'rails_helper'

RSpec.describe Contract, type: :model do

  def valid_params
    {
      currency_amount: 10
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:bug) }
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
# Table name: contracts
#
#  id              :integer          not null, primary key
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_type   :string
#  currency_amount :float
#  terms           :string
#  expire_at       :datetime
#  bug_id          :integer
#  repo_id         :integer
#  title           :string
#  status          :string
#  labels          :string
#  assert_match    :boolean
#  jfields         :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
