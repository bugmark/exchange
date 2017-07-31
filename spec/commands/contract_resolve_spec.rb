require 'rails_helper'

RSpec.describe ContractResolve, type: :model do

  def contract_params
    {
      currency_amount: 10            ,
      publisher_id:    user.id       ,
      counterparty_id: user.id
    }
  end

  let(:kontrakt) { Contract.create(contract_params)                       }
  let(:user)     { User.create(email: 'xx@yy.com', password: 'yyyyyy')    }
  let(:klas)     { described_class                                        }
  subject        { klas.find(kontrakt.id)                                 }

  describe "Attributes" do
    it { should respond_to :counterparty           }
    it { should respond_to :contract               }
    it { should respond_to :currency_amount        }
  end

  describe "Subobjects" do
    it { should respond_to :subobject_symbols }
    it { should respond_to :subobjects        }
    it { should respond_to :subs              }
    it 'returns an array' do
      expect(subject.subobjects).to be_an(Array)
    end
  end

  describe "Delegated Object" do
    it 'has a present Contract' do
      expect(subject.contract).to be_present
    end

    it 'has a Contract with the right class' do
      expect(subject.contract).to be_a(Contract)
    end

    it 'should have a valid Contract' do
      expect(subject.contract).to be_valid
    end
  end

  # describe "Object Saving" do
  #   it 'saves the object to the database' do
  #     subject.save
  #     expect(subject).to be_valid
  #   end
  #
  #   it 'gets the right object count' do
  #     expect(kontrakt).to be_present
  #     expect(Contract.count).to eq(1)
  #     subject.save
  #     expect(Contract.count).to eq(1)
  #   end
  # end

  # describe "Object Transaction" do
  #   it 'adjusts the user balance' do
  #     expect(user.pokerbux_balance).to eq(100)
  #     subject.save
  #     user.reload
  #     expect(user.pokerbux_balance).to eq(90)
  #   end
  # end
end

