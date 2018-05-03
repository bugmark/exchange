require 'rails_helper'

RSpec.describe IssueCmd::Sync do

  require 'rails_helper'

  def valid_params(opts = {})
    {
      stm_tracker_uuid: tracker.uuid          ,
      stm_title:     "Tst Issue 1"      ,
      stm_status:    "open"             ,
      stm_comments:  []                 ,
      type:          "Issue::Test"      ,
      exid:          SecureRandom.uuid
    }.merge(opts)
  end

  let(:tracker) { FB.create(:tracker).tracker }
  let(:klas) { described_class       }
  subject { klas.new(valid_params)   }

  describe "Attributes" do
    it { should respond_to :issue_new   }
    it { should respond_to :issue_event }
  end

  describe "Object Existence" do
    it { should be_a klas }
    it { should be_valid  }
  end

  describe "#project" do
    context "creating an issue" do
      it 'saves the object to the database' do
        subject.project
        expect(subject).to be_valid
      end

      it 'gets the right Tracker count' do
        expect(Tracker.count).to eq(0)
        subject.project
        expect(Tracker.count).to eq(1)
      end

      it 'gets the right Issue count' do
        expect(Issue.count).to eq(0)
        subject.project
        expect(Issue.count).to eq(1)
      end

      it 'gets the right Event count' do
        expect(Event.count).to eq(0)
        subject.project
        expect(Event.count).to eq(2)
      end
    end

    context "updating an issue" do
      it 'updates the item' do
        exid = "HELLOWORLD"
        obj1 = klas.new(valid_params(exid: exid)).project.issue
        expect(Issue.count).to eq(1)
        obj2 = klas.new(valid_params(exid: exid, stm_title: "xxx")).project.issue
        expect(Issue.count).to eq(1)
        expect(obj1.stm_title).to_not eq(obj2.stm_title)
        expect(obj1.id).to eq(obj2.id)
      end
    end
  end
end

