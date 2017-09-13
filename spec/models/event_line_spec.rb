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
