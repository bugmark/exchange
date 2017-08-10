
# use for either request specs or feature specs:
# describe 'Inbound Letter Opener' do
#   include_context 'Integration Environment'
#   ...
RSpec.shared_context 'Integration Environment' do
  let(:bug1)   { FG.create(:bug                                              }
  let(:bug2)   { FG.create(:team, org_id: orgn.id)                           }
  let(:team2)  { FG.create(:team, org_id: orgn.id)                           }
  let(:pagr1)  { Pgr.create(team_id: team1.id)                               }
  let(:pagr2)  { Pgr.create(team_id: team2.id)                               }
  let(:usr0)   { FG.create(:user_with_phone_and_email)                       }
  let(:usr1)   { FG.create(:user_with_phone_and_email)                       }
  let(:usr2)   { FG.create(:user_with_phone_and_email)                       }
  let(:usr3)   { FG.create(:user_with_phone_and_email)                       }
  let(:mem1)   { FG.create(:membership, team_id: team1.id, user_id: usr1.id) }
  let(:mem2)   { FG.create(:membership, team_id: team1.id, user_id: usr2.id) }
  let(:mem3)   { FG.create(:membership, team_id: team2.id, user_id: usr3.id) }
  let(:sendr)  { FG.create(:membership, team_id: team1.id, user_id: usr0.id) }
  let(:recp1)  { FG.create(:membership, team_id: team1.id, user_id: usr1.id) }
  let(:recp2)  { FG.create(:membership, team_id: team1.id, user_id: usr2.id) }
  let(:recp3)  { FG.create(:membership, team_id: team1.id, user_id: usr3.id) }
  let(:mmail1) { mem1; "#{usr1.user_name}@#{team1.fqdn}"                     }
  let(:mmail2) { mem2; "#{usr2.user_name}@#{team1.fqdn}"                     }
  let(:mmail3) { mem3; "#{usr3.user_name}@#{team2.fqdn}"                     }
  let(:email1) { mem1; usr1.emails.first.address                             }
  let(:email2) { mem2; usr2.emails.first.address                             }
  let(:email3) { mem3; usr3.emails.first.address                             }
  let(:role1)  { team1.roles.first                                           }
  let(:pos1)   { role1.create_position(team: team1)                          }
  let(:team2_url) { "http://#{team2.fqdn}"                                   }
  let(:team1_url) { "http://#{team1.fqdn}"                                   }
  let(:partnership) do
    opts = {team_id: team1.id, partner_id: team2.id, status: 'accepted'}
    TeamPartnership.create(opts)
  end

  let(:bcst1) { Pgr::Broadcast.create(bcst1_params)                          }
  let(:bcst2) { Pgr::Broadcast.create(bcst2_params)                          }

  def bcst1_params
    {
      'sender_id'              => sendr.id,
      'short_body'             => 'Hello World',
      'long_body'              => 'Hello Long Body World',
      'email'                  => true,
      'sms'                    => true,
      'recipient_ids'          => [recp1.id],
    }
  end

  def bcst2_params
    bcst1_params.merge({'recipient_ids' => [recp1.id, recp2.id]})
  end

end

def hydrate(*args); end

