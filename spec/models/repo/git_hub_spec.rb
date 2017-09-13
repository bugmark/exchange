require 'rails_helper'

RSpec.describe Repo::GitHub, type: :model do
  def valid_params
    {
      name: "asdf/qwer",
    }
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  # describe "Object Creation" do
  #   it { should be_valid }
  #
  #   it 'saves the object to the database' do
  #     subject.save
  #     expect(subject).to be_valid
  #   end
  # end
end
