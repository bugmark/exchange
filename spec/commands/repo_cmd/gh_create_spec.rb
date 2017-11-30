require 'rails_helper'

RSpec.describe RepoCmd::GhCreate do

  require 'rails_helper'

  def valid_params
    {
      name: "mvscorg/test1"
    }
  end

  let(:klas) { described_class }
  subject { klas.new(valid_params) }

  describe "Attributes" do
    it { should respond_to :repo }
  end

  describe "Object Existence" do
    it { should be_a klas }
    it { should be_valid }
  end

  describe "Subobjects" do
    it { should respond_to :subobject_symbols }
    it 'returns an array' do
      expect(subject.subobject_symbols).to be_an(Array)
    end
  end

  describe "Delegated Object" do
    it 'has a present Repo' do
      expect(subject.repo).to be_present
    end

    it 'has a Repo with the right class' do
      expect(subject.repo).to be_a(Repo)
    end

    it 'should have a valid Repo' do
      expect(subject.repo).to be_valid
    end
  end

  describe "#project" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Repo.count).to eq(0)
      subject.project
      expect(Repo.count).to eq(1)
    end
  end

  describe "#event_data" do
    it 'returns a hash' do
      expect(subject.event_data).to be_a(Hash)
    end

    it 'has expected hash keys' do
      keys = subject.event_data.keys
      expect(keys).to include("id")
    end
  end

  describe "#event_save" do
    it 'creates an event' do
      expect(EventLine.count).to eq(0)
      subject.project
      expect(EventLine.count).to eq(1)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(Repo.count).to eq(0)
      subject.project
      expect(EventLine.count).to eq(1)
      expect(Repo.count).to eq(1)
    end
  end
end

