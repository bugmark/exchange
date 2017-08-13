require 'rails_helper'

RSpec.describe RepoCmd::GhCreate, type: :model do

  def valid_params
    {
      token_value:  10            ,
      publisher_id: user.id
    }
  end

  let(:user)   { User.create(email: 'xx@yy.com', password: 'yyyyyy')    }
  let(:klas)   { described_class                                        }
  subject      { klas.new(valid_params)                                 }

end

