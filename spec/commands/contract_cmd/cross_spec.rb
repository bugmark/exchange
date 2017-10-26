require 'rails_helper'

RSpec.describe ContractCmd::Cross do

  include_context 'Integration Environment'

  let(:ask)    { FG.create(:buy_ask, user_id: usr1.id).offer         }
  let(:bid)    { FG.create(:buy_bid, user_id: usr2.id).offer         }
  let(:user)   { FG.create(:user).user                               }
  let(:klas)   { described_class                                     }
  subject      { klas.new(ask, :expand)                              }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer           }
    it { should respond_to :counters      }
    it { should respond_to :type        }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas       }
    it { should_not be_valid    }
  end
end