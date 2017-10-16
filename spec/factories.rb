require 'factory_girl'
require_relative "../app/commands/application_command"
# Dir["app/commands/**/*.rb"].each {|f| require_relative "../#{f}"}

FG ||= FactoryGirl

FactoryGirl.define do

  factory :user, class: UserCmd::Create do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    sequence :email do |n| "test#{n}@bugmark.net" end
    password              "bugmark"
    token_balance         100.0
  end

  factory :repo, class: RepoCmd::GhCreate do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    type     "Repo::GitHub"
    name     "mvscorg/bugmark"
  end

  factory :bug, class: BugCmd::Sync do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    sequence :title do |n| "Bug #{n}" end
    repo_id  { FG.create(:repo).id }
  end

  factory :buy_bid, class: BuyBidCmd::Create do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    price               0.20
    volume              10
    contract_maturation Time.now + 1.day
    bug_id              { FG.create(:bug).id  }
    user_id             { FG.create(:user).id }

    factory :matured_bid do
      contract_maturation Time.now - 1.day
    end
  end

  factory :buy_ask, class: BuyAskCmd::Create do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(attributes) }

    price               0.40
    volume              10
    contract_maturation Time.now + 1.day
    bug_id              { FG.create(:bug).id  }
    user_id             { FG.create(:user).id }

    factory :matured_ask do
      contract_maturation Time.now - 1.day
    end
  end

  factory :position do
  end

  factory :escrow do
  end

  # factory :contract, class: ContractCmd::Publish do
  #   to_create {|instance| instance.save_event.project}
  #   initialize_with { new(attributes) }
  #
  #   type         "Contract::GitHub"
  #   token_value  20
  #   terms        "Net10"
  #   contract_maturation   Time.now + 1.day
  #   bug_id       { FG.create(:bug).id  }
  #   # user_id      { FG.create(:user).id }
  #
  #   factory :matured_contract do
  #     contract_maturation Time.now - 1.day
  #   end
  #
  #   factory :taken_contract do
  #     counterparty_id { FG.create(:user).id }
  #   end
  #
  #   factory :taken_matured_contract do
  #     counterparty_id { FG.create(:user).id }
  #     contract_maturation      Time.now - 1.day
  #   end
  #  end

end
