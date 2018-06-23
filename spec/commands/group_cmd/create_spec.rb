require 'rails_helper'

RSpec.describe GroupCmd::Create do

  require 'rails_helper'

  def valid_params
    {
      name: "Test1"            ,
      uuid: SecureRandom.uuid  ,
      owner_uuid: user.uuid
    }
  end

  let(:user) { FB.create(:user).user              }
  let(:klas) { described_class                    }
  subject { klas.new(valid_params).project.group  }

  describe "Attributes" do
    it { should respond_to :name       }
    it { should respond_to :uuid       }
    it { should respond_to :owner_uuid }
  end
end
