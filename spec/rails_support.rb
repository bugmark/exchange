# use for either request specs or feature specs:
# describe 'My Feature' do
#   include_context 'Integration Environment'
#   ...
RSpec.shared_context 'Integration Environment' do
  let(:usr1)   { FG.create(:user)                                  }
  let(:usr2)   { FG.create(:user)                                  }
  let(:usr3)   { FG.create(:user)                                  }
  let(:usr4)   { FG.create(:user)                                  }
  let(:repo1)  { FG.create(:repo)                                  }
  let(:repo2)  { FG.create(:repo)                                  }
  let(:bug1)   { FG.create(:bug, repo_id: repo1.id)                }
  let(:bug2)   { FG.create(:bug, repo_id: repo1.id)                }
  let(:con1)   { FG.create(:contract, publisher_id: usr1.id)       }
  let(:con2)   { FG.create(:contract, publisher_id: usr2.id)       }
end

def hydrate(*args); end

