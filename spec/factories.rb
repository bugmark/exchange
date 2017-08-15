FG ||= FactoryGirl

FactoryGirl.define do

  factory :user, class: UserCmd::Create do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    sequence :email do |n| "test#{n}@bugmark.net" end
    password              "bugmark"
  end

  factory :repo, class: RepoCmd::GhCreate do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    sequence :json_url do |n| "http://placeholder#{n}.com" end
    sequence :name     do |n| "mvscorg/test#{n}" end
  end

  factory :bug, class: BugCmd::Sync do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    sequence :title do |n| "Bug #{n}" end
    sequence :json_url do |n| "http://placeholder#{n}.com" end
    repo_id  { FG.create(:repo).id }
  end

  factory :contract, class: ContractCmd::Publish do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    type         "Contract::Forecast"
    token_value  20
    terms        "Net10"
    matures_at   Time.now + 1.day
    bug_id       { FG.create(:bug).id  }
    publisher_id { FG.create(:user).id }

    factory :matured_contract do
      matures_at Time.now - 1.day
    end

    factory :taken_contract do
      counterparty_id { FG.create(:user).id }
    end

    factory :taken_matured_contract do
      counterparty_id { FG.create(:user).id }
      matures_at      Time.now - 1.day
    end
   end

end
