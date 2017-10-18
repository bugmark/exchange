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
    balance         100.0
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

    sequence    :stm_title do |n| "Bug #{n}" end
    stm_repo_id { FG.create(:repo).id }
  end

  factory :buy_bid, class: OfferBuyCmd::Create do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(:bid, attributes) }

    price               0.60
    volume              10
    status              "open"
    maturation Time.now + 1.day
    stm_bug_id          { FG.create(:bug).id  }
    user_id             { FG.create(:user).id }

    factory :matured_bid do
      maturation Time.now - 1.day
    end
  end

  factory :buy_ask, class: OfferBuyCmd::Create do
    to_create {|instance| instance.save_event.project}
    initialize_with { new(:ask, attributes) }

    price               0.40
    volume              10
    maturation Time.now + 1.day
    stm_bug_id          { FG.create(:bug).id  }
    user_id             { FG.create(:user).id }

    factory :matured_ask do
      maturation Time.now - 1.day
    end
  end

  factory :position do
  end

  factory :escrow do
  end

  factory :base_contract, class: Contract do

    status              'open'
    maturation Time.now + 1.minute

  end

  # factory :contract, class: ContractCmd::Publish do
  #   to_create {|instance| instance.save_event.project}
  #   initialize_with { new(attributes) }
  #
  #   type         "Contract::GitHub"
  #   token_value  20
  #   terms        "Net10"
  #   maturation   Time.now + 1.day
  #   bug_id       { FG.create(:bug).id  }
  #   # user_id      { FG.create(:user).id }
  #
  #   factory :matured_contract do
  #     maturation Time.now - 1.day
  #   end
  #
  #   factory :taken_contract do
  #     counterparty_id { FG.create(:user).id }
  #   end
  #
  #   factory :taken_matured_contract do
  #     counterparty_id { FG.create(:user).id }
  #     maturation      Time.now - 1.day
  #   end
  #  end

end
