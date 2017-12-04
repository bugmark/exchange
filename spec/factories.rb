require 'factory_bot'
require_relative "../app/commands/application_command"

FB ||= FactoryBot

FactoryBot.define do

  # ----- BASE -----

  factory :user, class: UserCmd::Create do
    to_create { |instance| instance.project }
    initialize_with { new(attributes) }

    sequence :email do |n|
      "test#{n}@bugmark.net"
    end
    password "bugmark"
    balance 1000.0
  end

  factory :repo, class: RepoCmd::GhCreate do
    to_create { |instance| instance.project }
    initialize_with { new(attributes) }

    type "Repo::GitHub"
    name "mvscorg/bugmark"
  end

  factory :bug, class: BugCmd::Sync do
    to_create { |instance| instance.project }
    initialize_with { new(attributes) }

    sequence :stm_title do |n|
      "Bug #{n}"
    end
    stm_repo_id { FB.create(:repo).id }
  end

  # ----- BUY OFFERS -----

  factory :offer_bu, class: OfferCmd::CreateBuy do
    to_create { |instance| instance.project }
    initialize_with { new(:offer_bu, attributes) }

    price  0.60
    volume 10
    status "open"
    maturation Time.now + 1.day
    user       { FB.create(:user).user   }
    stm_bug_id { FB.create(:bug).id      }
    stm_status "closed"
    poolable   false
    aon        false

    factory :matured_bid do
      maturation Time.now - 1.day
    end
  end

  factory :offer_bf, class: OfferCmd::CreateBuy do
    to_create { |instance| instance.project }
    initialize_with { new(:offer_bf, attributes) }

    price      0.40
    volume     10
    status     "open"
    maturation Time.now + 1.day
    user       { FB.create(:user).user    }
    stm_bug_id { FB.create(:bug).id       }
    stm_status "closed"
    poolable   false
    aon        false

    factory :matured_ask do
      maturation Time.now - 1.day
    end
  end

  # ----- CONTRACTS AND ARTIFACTS -----

  factory :contract do
    status 'open'
    type "Contract::GitHub"
    maturation Time.now + 1.day

    factory :matured_contract do
      maturation Time.now - 1.day
    end
  end

  factory :position do
    contract { FB.create(:contract)  }
    user     { FB.create(:user).user }
    offer    { FB.create(:offer_bu, user: user, status: 'crossed').offer }
    volume   { offer.volume }
    price    { offer.price  }

    factory :unfixed_position do
      offer { FB.create(:offer_bu, user: user, status: 'crossed').offer }
    end

    factory :fixed_position do
      offer { FB.create(:offer_bf, user: user, status: 'crossed').offer }
    end
  end

  factory :escrow do
    type      "Escrow::Expand"
    contract  { FB.create(:contract)   }
    amendment { FB.create(:amendment)  }
  end

  # ----- SELL OFFERS -----

  factory :offer_su, class: OfferCmd::CreateSell do
    to_create { |instance| instance.project }
    initialize_with do
      offer_bf = FB.create(:offer_bf).offer
      offer_bu = FB.create(:offer_bu).offer
      _cross   = ContractCmd::Cross.new(offer_bf, :expand)
      _result  = _cross.project
      new(offer_bu.position, attributes || {})
    end
  end

  factory :offer_sf, class: OfferCmd::CreateSell do
    to_create { |instance| instance.project }
    initialize_with do
      offer_bu = FB.create(:offer_bu).offer
      offer_bf = FB.create(:offer_bf).offer
      _cross   = ContractCmd::Cross.new(offer_bu, :expand)
      _result  = _cross.project
      new(offer_bf.position, attributes || {})
    end
  end
end

module FBX

  def expand_obf(opts = {})
    _obu, obf = FBX.create_buy_offers(opts)
    ContractCmd::Cross.new(obf, :expand).project
  end

  def expand_obu(opts = {})
    obu, _obf = FBX.create_buy_offers(opts)
    ContractCmd::Cross.new(obu, :expand).project
  end

  def offer_sf(opts = {})
    obu, _obf = FBX.create_buy_offers(opts)
    cnt = ContractCmd::Cross.new(obu, :expand).project.contract
    pos = cnt.escrows.last.fixed_positions.first
    OfferCmd::CreateSell.new(pos, FBX.opts_for(:osf, opts)).project
  end

  module_function :expand_obf, :expand_obu, :offer_sf

  # ----- private -----

  def FBX.create_buy_offers(opts)
    obu = FB.create(:offer_bu, FBX.opts_for(:obu, opts)).offer
    obf = FB.create(:offer_bf, FBX.opts_for(:obf, opts)).offer
    [obu, obf]
  end

  def FBX.opts_for(tag, opts)
    FBX.default_opts.fetch(tag, {}).merge(opts.fetch(tag, {}))
  end

  def FBX.default_opts
    {
      obf: {},
      obu: {},
      osf: {},
      osu: {},
    }
  end
end
