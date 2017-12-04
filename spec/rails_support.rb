# use for either request specs or feature specs:
# describe 'My Feature' do
#   include_context 'Integration Environment'
#   ...
RSpec.shared_context 'Integration Environment' do
  let(:usr1)  { FB.create(:user).user                                     }
  let(:usr2)  { FB.create(:user).user                                     }
  let(:usr3)  { FB.create(:user).user                                     }
  let(:usr4)  { FB.create(:user).user                                     }
  let(:repo1) { FB.create(:repo)                                          }
  let(:repo2) { FB.create(:repo)                                          }
  let(:bug1)  { FB.create(:bug , stm_repo_id: repo1.id)                   }
  let(:bug2)  { FB.create(:bug , stm_repo_id: repo1.id)                   }

  let(:offer_bu1)  { FB.create(:offer_bu , stm_repo_id: repo1.id, user_id: usr1.id) }
  let(:offer_bu2)  { FB.create(:offer_bu , stm_repo_id: repo2.id)                   }
  let(:offer_bu3)  { FB.create(:offer_bu , stm_bug_id:  bug1.id)                    }
  let(:offer_bf1)  { FB.create(:offer_bf , stm_repo_id: repo1.id, user_id: usr2.id) }
  let(:offer_bf2)  { FB.create(:offer_bf , stm_repo_id: repo2.id)                   }
  let(:offer_bf3)  { FB.create(:offer_bf , stm_bug_id:  bug1.id)                    }

  # let(:con1)   { FB.create(:contract, offer_bf_id: usr1.id)                }
  # let(:con2)   { FB.create(:contract, user_id: usr2.id)               }
end

def hydrate(*args); end

