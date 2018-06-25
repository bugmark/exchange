require 'rails_helper'

RSpec.describe UserCmd::MembershipOpen do

  require 'rails_helper'

  def valid_params
    {
      uuid: SecureRandom.uuid  ,
      user_uuid:  user.uuid    ,
      group_uuid: group.uuid
    }
  end

  let(:group) { FB.create(:user_group).group       }
  let(:user)  { FB.create(:user).user              }
  let(:klas)  { described_class                    }
  subject { klas.new(valid_params).project.group   }

  describe "Attributes" do
    it { should respond_to :uuid        }
    it { should respond_to :user_uuid   }
    it { should respond_to :group_uuid  }
  end
end
