# use for either request specs or feature specs:
# describe 'My Feature' do
#   include_context 'Integration Environment'
#   ...
RSpec.shared_context 'Integration Environment' do
  let(:usr1)  { FG.create(:user).user                                }
  let(:usr2)  { FG.create(:user).user                                }
  let(:usr3)  { FG.create(:user).user                                }
  let(:usr4)  { FG.create(:user).user                                }
  let(:repo1) { FG.create(:repo)                                     }
  let(:repo2) { FG.create(:repo)                                     }
  let(:bug1)  { FG.create(:bug, repo_id: repo1.id)                   }
  let(:bug2)  { FG.create(:bug, repo_id: repo1.id)                   }
  let(:bid1)  { FG.create(:bid, repo_id: repo1.id, user_id: usr1.id, price: 0.60) }
  let(:bid2)  { FG.create(:bid, repo_id: repo2.id)                   }
  let(:bid3)  { FG.create(:bid, bug_id:  bug1.id)                    }
  let(:ask1)  { FG.create(:ask, repo_id: repo1.id, user_id: usr2.id) }
  let(:ask2)  { FG.create(:ask, repo_id: repo2.id)                   }
  let(:ask3)  { FG.create(:ask, bug_id:  bug1.id)                    }
  # let(:con1)   { FG.create(:contract, ask_id: usr1.id)                }
  # let(:con2)   { FG.create(:contract, user_id: usr2.id)               }
end

def hydrate(*args); end

