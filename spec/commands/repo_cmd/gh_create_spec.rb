require 'rails_helper'

RSpec.describe RepoCmd::GhCreate do

  require 'rails_helper'

  def valid_params
    {
      name: "mvscorg/test1"     ,
      uuid: SecureRandom.uuid
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
      subject.cmd_cast
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Repo.count).to eq(0)
      subject.cmd_cast
      expect(Repo.count).to eq(1)
    end
  end
end

