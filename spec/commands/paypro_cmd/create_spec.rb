require 'rails_helper'

RSpec.describe PayproCmd::Create do

  require 'rails_helper'

  def valid_params
    {
      name: "Test1"            ,
      uuid: SecureRandom.uuid  ,
      currency: "XTS"
    }
  end

  let(:klas) { described_class }
  subject { klas.new(valid_params).project.paypro }

  describe "Attributes" do
    it { should respond_to :name     }
    it { should respond_to :status   }
    it { should respond_to :currency }
    it { should respond_to :pubkey   }
  end
end

