# use for either request specs or feature specs:
# describe 'My Feature' do
#   include_context 'Integration Environment'
#   ...
RSpec.shared_context 'Integration Environment' do
  let(:usr1)  { FB.create(:user).user                                     }
  let(:usr2)  { FB.create(:user).user                                     }
  let(:usr3)  { FB.create(:user).user                                     }
  let(:usr4)  { FB.create(:user).user                                     }
  let(:repo1) { FB.create(:repo).repo                                     }
  let(:repo2) { FB.create(:repo).repo                                     }
  let(:issue1)  { FB.create(:issue , stm_repo_uuid: repo1.uuid)               }
  let(:issue2)  { FB.create(:issue , stm_repo_uuid: repo1.uuid)               }

  let(:offer_bu1) { FB.create(:offer_bu , stm_repo_uuid: repo1.uuid, user: usr1) }
  let(:offer_bu2) { FB.create(:offer_bu , stm_repo_uuid: repo2.uuid)             }
  let(:offer_bu3) { FB.create(:offer_bu , stm_issue_uuid:  bug1.uuid)              }
  let(:offer_bf1) { FB.create(:offer_bf , stm_repo_uuid: repo1.uuid, user: usr2) }
  let(:offer_bf2) { FB.create(:offer_bf , stm_repo_uuid: repo2.uuid)             }
  let(:offer_bf3) { FB.create(:offer_bf , stm_issue_uuid:  bug1.uuid)              }
end

def hydrate(*args); end

