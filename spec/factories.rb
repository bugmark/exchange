require 'ostruct'
require 'factory_bot'
require_relative "../app/commands/application_command"

FB ||= FactoryBot

FactoryBot.define do

  # ----- BASE -----

  factory :user, class: UserCmd::Create do
    to_create { |instance| instance.project }
    initialize_with { new(attributes) }

    sequence :email do |n|
      random = ('a'..'z').to_a.shuffle[0,8].join
      "#{random}#{n}@bugmark.net"
    end
    password "bugmark"
    balance 1000.0
  end

  factory :repo, class: RepoCmd::GhCreate do
    to_create { |instance| instance.project }
    initialize_with { new(attributes) }

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
    stm_repo_uuid { FB.create(:repo).repo&.uuid || Repo.first&.uuid || SecureRandom.uuid  }
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
  def position_f(opts = {})
    _obu, obf = FBX.create_buy_offers(opts)
    ContractCmd::Cross.new(obf, :expand).project
    obf.reload
    obf.position
  end

  def position_u(opts = {})
    obu, _obf = FBX.create_buy_offers(opts)
    ContractCmd::Cross.new(obu, :expand).project
    obu.reload
    obu.position
  end

  def expand_obf(opts = {})
    _obu, obf = FBX.create_buy_offers(opts)
    ContractCmd::Cross.new(obf, :expand).project
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

  module_function :offer_sf   , :offer_su
  module_function :position_f , :position_u
  module_function :expand_obf , :expand_obu

  # ----- private -----

  def FBX.create_buy_offers(opts)
    bug      = FB.create(:bug).bug
    xopt     = opts.merge({stm_bug_uuid: bug.uuid})
    obu_opts = FBX.opts_for(:obu, xopt)
    obf_opts = FBX.opts_for(:obf, xopt)
    obu      = FB.create(:offer_bu, obu_opts).offer
    obf      = FB.create(:offer_bf, obf_opts).offer
    [obu, obf]
  end

  def FBX.opts_for(tag, opts)
    FBX.default_opts.fetch(tag, {}).merge(opts.fetch(tag, {}))
  end

  def FBX.default_opts
    {
      obf: {uuid: SecureRandom.uuid},
      obu: {uuid: SecureRandom.uuid},
      osf: {uuid: SecureRandom.uuid},
      osu: {uuid: SecureRandom.uuid},
    }
  end
end
