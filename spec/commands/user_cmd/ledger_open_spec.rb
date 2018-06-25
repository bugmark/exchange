require 'rails_helper'

RSpec.describe UserCmd::LedgerOpen do

  require 'rails_helper'

  def valid_params
    {
      uuid:        SecureRandom.uuid  ,
      user_uuid:   user.uuid          ,
      paypro_uuid: paypro.uuid        ,
      currency:    "XTS"
    }
  end

  let(:paypro) { FB.create(:paypro).paypro          }
  let(:user)   { FB.create(:user).user              }
  let(:klas)   { described_class                    }
  subject { klas.new(valid_params).project.ledger   }

  describe "Attributes" do
    it { should respond_to :uuid        }
    it { should respond_to :user_uuid   }
  end
end
