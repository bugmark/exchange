require 'rails_helper'

RSpec.describe ContractCmd::Cross do

  include_context 'Integration Environment'

  let(:ask)    { FB.create(:offer_bf, user: usr1).offer    }
  let(:bid)    { FB.create(:offer_bu, user: usr2).offer    }
  let(:user)   { FB.create(:user).user                     }
  let(:klas)   { described_class                           }
  subject      { klas.new(ask, :expand)                    }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer           }
    it { should respond_to :counters        }
    it { should respond_to :type            }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas       }
    it { should_not be_valid    }
  end
end