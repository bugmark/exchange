require 'rails_helper'

RSpec.describe Ask, type: :model do

  def valid_params(user)
    {
      user_id: user.id
    }
  end

  let(:klas)   { described_class                            }
  let(:user)   { FG.create(:user)                           }
  subject      { klas.new(valid_params(user))               }

  describe "Attributes" do
    it { should respond_to :style                  }
    it { should respond_to :exref                  }
    it { should respond_to :uuref                  }
  end

  describe "#uuref" do
    it 'generates a string' do
      subject.save
      expect(subject.uuref).to be_a(String)
    end #

    it 'generates a 36-character string' do
      subject.save
      expect(subject.uuref.length).to eq(36)
    end
  end

  describe "Associations" do
    it { should respond_to(:user)         }
    it { should respond_to(:repo)         }
    it { should respond_to(:contract)     }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end

  describe "Scopes" do
    it 'has scope methods' do
      expect(klas).to respond_to :base_scope
      expect(klas).to respond_to :by_id
      expect(klas).to respond_to :by_repoid
      expect(klas).to respond_to :by_title
      expect(klas).to respond_to :by_status
      expect(klas).to respond_to :by_labels
    end
  end

  describe ".by_id" do
    before(:each) { subject.save}

    it 'returns a matching record' do
      expect(klas.by_id(subject.id).count).to eq(1)
    end
  end

end

# == Schema Information
#
# Table name: asks
#
#  id                  :integer          not null, primary key
#  type                :string
#  user_id             :integer
#  ownership           :string
#  contract_id         :integer
#  token_value         :integer
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  bug_presence        :boolean
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
