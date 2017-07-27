require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_params
    {
      email:    "asdf@qwer.net"   ,
      password: "gggggg"
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Associations" do
    it { should respond_to(:published_contracts)     }
    it { should respond_to(:taken_contracts)         }
  end

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.save
      expect(subject).to be_valid
    end
  end
end
