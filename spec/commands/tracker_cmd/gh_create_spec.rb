require 'rails_helper'

RSpec.describe TrackerCmd::GhCreate do

  require 'rails_helper'

  def valid_params
    {
      name: "mvscorg/bugmark"     ,
      uuid: SecureRandom.uuid
    }
  end

  let(:klas) { described_class }
  subject { klas.new(valid_params) }

  describe "Attributes" do
    it { should respond_to :tracker_new   }
    it { should respond_to :tracker_event }
  end

  describe "Object Existence" do
    it { should be_a klas }
    it { should be_valid }
  end

  describe "#cmd_cast", USE_VCR do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Tracker.count).to eq(0)
      subject.project
      expect(Tracker.count).to eq(1)
    end
  end
end

