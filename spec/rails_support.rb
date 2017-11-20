# use for either request specs or feature specs:
# describe 'My Feature' do
#   include_context 'Integration Environment'
#   ...
RSpec.shared_context 'Integration Environment' do
  let(:usr1)  { FG.create(:user).user                                     }
  let(:usr2)  { FG.create(:user).user                                     }
  let(:usr3)  { FG.create(:user).user                                     }
  let(:usr4)  { FG.create(:user).user                                     }
  let(:repo1) { FG.create(:repo)                                          }
  let(:repo2) { FG.create(:repo)                                          }
  let(:bug1)  { FG.create(:bug , stm_repo_id: repo1.id)                   }
  let(:bug2)  { FG.create(:bug , stm_repo_id: repo1.id)                   }

  let(:offer_bu1)  { FG.create(:offer_bu , stm_repo_id: repo1.id, user_id: usr1.id) }
  let(:offer_bu2)  { FG.create(:offer_bu , stm_repo_id: repo2.id)                   }
  let(:offer_bu3)  { FG.create(:offer_bu , stm_bug_id:  bug1.id)                    }
  let(:offer_bf1)  { FG.create(:offer_bf , stm_repo_id: repo1.id, user_id: usr2.id) }
  let(:offer_bf2)  { FG.create(:offer_bf , stm_repo_id: repo2.id)                   }
  let(:offer_bf3)  { FG.create(:offer_bf , stm_bug_id:  bug1.id)                    }

  # let(:con1)   { FG.create(:contract, offer_bf_id: usr1.id)                }
  # let(:con2)   { FG.create(:contract, user_id: usr2.id)               }
end

def hydrate(*args); end

