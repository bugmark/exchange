require 'rails_helper'

RSpec.describe Bug, type: :model do

  def valid_params(repo, extra_params = {})
    {
      stm_repo_id: repo.id
    }.merge(extra_params)
  end

  let(:klas)   { described_class                            }
  let(:repo)   { Repo.create(name: "asdf/qwer")             }
  subject      { klas.new(valid_params(repo))               }

  describe "Attributes" do
    it { should respond_to :exref                  }
    it { should respond_to :uuref                  }
  end

  describe "Associations" do
    it { should respond_to(:repo)         }
    it { should respond_to(:contracts)    }
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

  describe ".match" do
    before(:each) { subject.save}

    it 'matches id' do
      expect(subject).to_not be_nil
      expect(klas.count).to eq(1)
      expect(klas.match({id: subject.id}).length).to eq(1)
    end
  end

  describe "#uuref" do
    it 'generates a string' do
      subject.save
      expect(subject.uuref).to be_a(String) #.
    end

    it 'generates a 36-character string' do
      subject.save
      expect(subject.uuref.length).to eq(36)
    end
  end

  describe "stm_bug_id" do
    it "starts empty" do
      expect(subject.stm_bug_id).to be_nil
    end

    it "fills when saved" do
      subject.save
      expect(subject.stm_bug_id).to_not be_nil
      expect(subject.stm_bug_id).to eq(subject.id)
    end
  end

  describe "#html_url" do
    it { should respond_to :html_url                   }
    it { should respond_to :html_url=                  }

    it "sets the html_url" do
      sub = klas.new(valid_params(repo, {html_url: "asdf"})) #
      expect(sub.html_url).to eq("asdf")
    end
  end
end

# == Schema Information
#
# Table name: bugs
#
#  id          :integer          not null, primary key
#  type        :string
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  stm_repo_id :integer
#  stm_bug_id  :integer
#  stm_title   :string
#  stm_status  :string
#  stm_labels  :string
#  stm_xfields :hstore           not null
#  stm_jfields :jsonb            not null
#
