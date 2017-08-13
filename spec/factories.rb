FG ||= FactoryGirl

FactoryGirl.define do

  factory :repo do
    type "Repo::GitHub"
    sequence :json_url do |n| "http://placeholder#{n}.com" end
    sequence :name     do |n| "mvscorg/test#{n}" end
  end

  factory :bug do
    sequence :title do |n| "Bug #{n}" end
    sequence :json_url do |n| "http://placeholder#{n}.com" end
    repo_id  { FG.create(:repo).id }
  end

  factory :user do
    sequence :email do |n| "test#{n}@bugmark.net" end
    password              "bugmark"
    password_confirmation "bugmark"
  end

  factory :contract, class: ContractPub do
    type        "Contract::Forecast"
    token_value 20
    terms       "Net10"
    matures_at  Time.now + 1.day
    bug_id      { FG.create(:bug).id  }
    user_id     { FG.create(:user).id }
  end

end
