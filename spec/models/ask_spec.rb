# require 'rails_helper'
#
# RSpec.describe Ask, type: :model do
#
#   def valid_params(user)
#     {
#       user_id: user.id
#     }
#   end
#
#   let(:klas)   { described_class                            }
#   let(:user)   { FG.create(:user)                           }
#   subject      { klas.new(valid_params(user))               }
#
#   describe "Attributes" do
#     it { should respond_to :exref                  }
#     it { should respond_to :uuref                  }
#     it { should respond_to :maturation_period      }
#   end
#
#   describe "Associations" do
#     it { should respond_to(:user)         }
#     it { should respond_to(:repo)         }
#     it { should respond_to(:contract)     }
#   end
#
#   describe "Instance Methods" do
#     it { should respond_to(:matching_bids)  }
#   end
#
#   describe "Object Creation" do
#     it { should be_valid }
#
#     it 'saves the object to the database' do
#       subject.save
#       expect(subject).to be_valid
#     end
#   end
#
#   describe "Scopes" do
#     it 'has scope methods' do
#       expect(klas).to respond_to :base_scope
#       expect(klas).to respond_to :by_id
#       expect(klas).to respond_to :by_repoid
#       expect(klas).to respond_to :by_title
#       expect(klas).to respond_to :by_status
#       expect(klas).to respond_to :by_labels
#       expect(klas).to respond_to :by_maturation_period #..
#     end
#   end
#
#   describe ".by_id" do
#     before(:each) { subject.save}
#
#     it 'returns a matching record' do
#       expect(klas.by_id(subject.id).count).to eq(1)
#     end
#   end
#
#   describe "#maturation_period" do
#     it 'saves dates' do
#       subject.maturation_period =  Date.new(2014, 2, 11)..Date.new(2014, 2, 12)
#       subject.save
#       expect(subject.maturation_period).to be_a(Range)
#     end
#
#     it 'saves dates as times' do
#       subject.maturation_period =  Date.new(2014, 2, 11)..Date.new(2014, 2, 12)
#       subject.save
#       expect(subject.maturation_period.begin).to be_a(Time)
#     end
#
#     it 'saves times' do
#       subject.maturation_period =  Time.now..Time.now+2.days
#       subject.save
#       expect(subject.maturation_period).to be_a(Range)
#     end
#
#     it 'saves times as times' do
#       subject.maturation_period =  Time.now..Time.now+2.days
#       subject.save
#       expect(subject.maturation_period.begin).to be_a(Time)
#     end
#
#     it 'queries period overlaps and find results' do
#       subject.maturation_period =  Time.now..Time.now+2.days
#       subject.save
#       res = klas.where("maturation_period && tsrange(?, ?)", Time.now, Time.now+1.hour)
#       expect(res.first.id).to eq(subject.id)
#     end
#
#     it 'queries and find results with period overlaps' do
#       subject.maturation_period =  Time.now..Time.now+2.days
#       subject.save
#       res = klas.where("maturation_period && tsrange(?, ?)", Time.now, Time.now+1.hour)
#       expect(res.first.id).to eq(subject.id)
#     end
#
#     it 'queries and returns nothing if no overlap' do
#       subject.maturation_period =  Time.now-3.days..Time.now-2.days
#       subject.save
#       res = klas.where("maturation_period && tsrange(?, ?)", Time.now, Time.now+1.hour)
#       expect(res.length).to eq(0)
#     end
#   end
#
#   describe "#uuref" do
#     it 'generates a string' do
#       subject.save
#       expect(subject.uuref).to be_a(String)
#     end #
#
#     it 'generates a 36-character string' do
#       subject.save
#       expect(subject.uuref.length).to eq(36)
#     end
#   end
# end

# == Schema Information
#
# Table name: asks
#
#  id                  :integer          not null, primary key
#  type                :string
#  user_id             :integer
#  contract_id         :integer
#  volume              :integer          default(1)
#  price               :float            default(0.5)
#  all_or_none         :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  maturation_period   :tsrange
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
