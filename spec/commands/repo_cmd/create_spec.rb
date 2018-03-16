require 'rails_helper'

RSpec.describe RepoCmd::Create do

  require 'rails_helper'

  def valid_params
    {
      name: "Test1"            ,
      uuid: SecureRandom.uuid  ,
      type: "Test"
    }
  end

  let(:klas) { described_class }
  subject { klas.new(valid_params) }

  describe "Attributes" do
    it { should respond_to :repo_new   }
    it { should respond_to :repo_event }
  end

  describe "Object Existence" do
    it { should be_a klas }
    it { should be_valid }
  end

  describe "#cmd_cast" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Repo.count).to eq(0)
      subject.project
      expect(Repo.count).to eq(1)
    end

    it 'gets the right event count' do
      expect(Event.count).to eq(0)
      subject.project
      expect(Event.count).to eq(1)
    end
  end
end

