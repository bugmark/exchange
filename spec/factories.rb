require 'factory_girl'
require_relative "../app/commands/application_command"

FG ||= FactoryGirl

FactoryGirl.define do

  factory :user, class: UserCmd::Create do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(attributes) }

    sequence :email do |n|
      "test#{n}@bugmark.net"
    end
    password "bugmark"
    balance 100.0
  end

  factory :repo, class: RepoCmd::GhCreate do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(attributes) }

    type "Repo::GitHub"
    name "mvscorg/bugmark"
  end

  factory :bug, class: BugCmd::Sync do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(attributes) }

    sequence :stm_title do |n|
      "Bug #{n}"
    end
    stm_repo_id { FG.create(:repo).id }
  end

  factory :offer_bu, class: OfferCmd::CreateBuy do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(:offer_bu, attributes) }

    price  0.60
    volume 10
    status "open"
    maturation Time.now + 1.day
    stm_bug_id { FG.create(:bug).id      }
    user       { FG.create(:user).user   }
    poolable   false
    aon        false

    factory :matured_bid do
      maturation Time.now - 1.day
    end
  end

  factory :offer_bf, class: OfferCmd::CreateBuy do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(:offer_bf, attributes) }

    price      0.40
    volume     10
    status     "open"
    maturation Time.now + 1.day
    stm_bug_id { FG.create(:bug).id       }
    user       { FG.create(:user).user    }
    poolable   false
    aon        false

    factory :matured_ask do
      maturation Time.now - 1.day
    end
  end

  factory :offer_su, class: OfferCmd::CreateSell do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(FG.create(:unfixed_position), attributes || {}) }
  end

  factory :offer_sf, class: OfferCmd::CreateSell do
    to_create { |instance| instance.save_event.project }
    initialize_with { new(FG.create(:fixed_position), attributes || {}) }
  end

  factory :position do
    contract { FG.create(:contract)  }
    user     { FG.create(:user).user }
    offer    { FG.create(:offer_bu, user: user, status: 'crossed').offer }
    volume   { offer.volume }
    price    { offer.price  }

    factory :unfixed_position do
      offer { FG.create(:offer_bu, user: user, status: 'crossed').offer }
    end

    factory :fixed_position do
      offer { FG.create(:offer_bf, user: user, status: 'crossed').offer }
    end
  end

  factory :escrow do
    type      "Escrow::Expand"
    contract  { FG.create(:contract)   }
    amendment { FG.create(:amendment)  }
  end

  factory :amendment do
  end

  factory :contract do
    status 'open'
    type "Contract::GitHub"
    maturation Time.now + 1.day

    factory :matured_contract do
      maturation Time.now - 1.day
    end
  end
end

