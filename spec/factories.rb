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
    sequence :exid do |n|
      "exid#{n}"
    end
    type "Bug::GitHub"
    stm_repo_uuid { FB.create(:repo).repo.uuid }
  end

  # ----- BUY OFFERS -----

  factory :offer_bu, class: OfferCmd::CreateBuy do
    to_create { |instance| instance.project }
    initialize_with { new(:offer_bu, attributes) }

    price  0.60
    volume 10
    maturation Time.now + 1.day
    user_uuid    { FB.create(:user).user.uuid   }
    stm_bug_uuid { FB.create(:bug).bug.uuid     }
    stm_status "closed"
    poolable   false
    aon        false
  end

  factory :offer_bf, class: OfferCmd::CreateBuy do
    to_create { |instance| instance.project }
    initialize_with { new(:offer_bf, attributes) }

    price      0.40
    volume     10
    maturation Time.now + 1.day
    user_uuid    { FB.create(:user).user.uuid   }
    stm_bug_uuid { FB.create(:bug).bug.uuid     }
    stm_status "closed"
    poolable   false
    aon        false
  end
end

module FBX

  def expand_obf(opts = {})
    _obu, obf = FBX.create_buy_offers(opts)
    res = ContractCmd::Cross.new(obf, :expand)
    res.project
  end

  def expand_obu(opts = {})
    obu, _obf = FBX.create_buy_offers(opts)
    ContractCmd::Cross.new(obu, :expand).project
  end

  def offer_sf(opts = {})
    _obu, obf = FBX.create_buy_offers(opts)
    cntr = ContractCmd::Cross.new(obf, :expand).project.contract
    posn = cntr.escrows.last.fixed_positions.first
    OfferCmd::CreateSell.new(posn, FBX.opts_for(:osf, opts)).project
  end

  def offer_su(opts = {})
    obu, _obf = FBX.create_buy_offers(opts)
    cntr = ContractCmd::Cross.new(obu, :expand).project.contract
    posn = cntr.escrows.last.unfixed_positions.first
    OfferCmd::CreateSell.new(posn, FBX.opts_for(:osu, opts)).project
  end

  module_function :expand_obf, :expand_obu, :offer_sf, :offer_su

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
