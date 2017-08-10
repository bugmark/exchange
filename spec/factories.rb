FG ||= FactoryGirl

FactoryGirl.define do

  # factory :bug do
  #   sequence :title    do |n| "Bug #{n}" end
  # end

  factory :user do
    sequence :email do |n| "test#{n}@bugmark.net" end
    password              "bugmark"
    password_confirmation "bugmark"
  end

#   factory :org do
#     typ 'enterprise'
#     sequence :name     do |n| "Org#{n}"     end
#     sequence :domain   do |n| "org#{n}.com" end
#     sequence :org_team_id do |n| n end
#   end
#
#   factory :team do
#     typ 'field'
#     sequence :name      do |n| "Team#{n}"  end
#     sequence :subdomain do |n| "team#{n}"  end
#   end
#
#   factory :team_nav do
#     sequence :path   do |n| "/n#{n}" end
#     sequence :label  do |n| "nav #{n}" end
#   end
#
#   factory :team_feature do
#     sequence :label do |n| "f#{n}" end
#     status    'on'
#   end
#
#   factory :team_rank, class: Team::Rank do
#     sequence :label    do |n| "X#{n}" end
#     sequence :name     do |n| "Role #{n}" end
#     sequence :sort_key do |n| n end
#     rights   'active'
#   end
#
#   factory :team_role, class: Team::Role do
#     sequence :label do |n| "X#{n}" end
#     sequence :name     do |n| "Field Member #{n}" end
#     sequence :sort_key do |n| n end
#   end
#
#   factory :member_rank do
#     sequence :label do |n| "x#{n}" end
#     name     'field member'
#     sequence :position do |n| n end
#   end
#
#   factory :member_attribute do
#     sequence :label do |n| "x#{n}" end
#     name     'TBD'
#     sequence :position do |n| n end
#   end
#
#   factory :role do
#     sequence :acronym do |n| "x#{n}" end
#     name        'important role'
#     sequence    :sort_key do |n| n end
#   end
#
#   factory :member_role do
#     sequence :label do |n| "x#{n}" end
#     name        'important role'
#     sequence    :position do |n| n end
#   end
#
#   factory :wiki_repo do
#     sequence     :name do |n| "Wiki#{n}" end
#     primary_type 'Team'
#     initialize_with { new(name: name, primary_type: primary_type)}
#   end
#
#   factory :membership do
#     sequence :team_id do |n| n end
#     sequence :user_id do |n| n end
#     rank     'ACT'
#     roles    []
#
#     factory :adm_mem, class: Membership do
#       rank     'OWN'
#     end
#
#   end
#
#   factory :user do
#     first_name 'John'
#     sequence :last_name  do |n| "Do#{'e' * n}" end
#     password 'smso'
#     password_confirmation 'smso'
#
#     transient do add_count 2 end
#
#     trait :with_phone do
#       after(:create) do |user, evaluator|
#         FactoryGirl.create_list(:user_phone, evaluator.add_count, :user => user)
#       end
#       after(:stub) do |user, evaluator|
#         FactoryGirl.build_stubbed_list(:user_phone, evaluator.add_count, :user => user)
#       end
#     end
#
#     trait :with_email do
#       after(:create) do |user, evaluator|
#         FactoryGirl.create_list(:user_email, evaluator.add_count, :user => user)
#       end
#       after(:stub) do |user, evaluator|
#         FactoryGirl.build_stubbed_list(:user_phone, evaluator.add_count, :user => user)
#       end
#     end
#
#     factory :user_with_phone,           :traits => [:with_phone]
#     factory :user_with_email,           :traits => [:with_email]
#     factory :user_with_phone_and_email, :traits => [:with_email, :with_phone]
#     factory :user_with_email_and_phone, :traits => [:with_email, :with_phone]
#
#   end
#
#   factory :user_email, class: User::Email do
#     pagable  '1'
#     sequence :address do |n| "member#{n}@email.com" end
#   end
#
#   factory :user_phone, class: User::Phone do
#     pagable  '1'
#     typ      'Mobile'
#     sequence :number    do |n|
#       num = n.to_s
#       idx = num.length * -1 - 1
#       base = '650-432-0000'
#       base[0..idx] + num
#     end
#   end
# end
#
# derived from http://blog.tobedevoured.com/post/54523066986/rspec-helper-to-add-find-or-create-to-factorygirl
# class FactoryHelper
#   class << self
#     def find_or_create(*args)
#       name, klas = parse_name_and_klas(args.shift)
#       lookup = args.shift
#       target = klas.where(lookup).try(:first)
#       target || FactoryGirl.create(name, lookup)
#     end
#
#     private
#
#     def parse_name_and_klas(name)
#       if name.is_a?(Hash)
#         [name.first[0], name.first[1].to_s.camelize.constantize]
#       else
#         [name, name.to_s.camelize.constantize]
#       end
#     end
#   end
# end
# FH ||= FactoryHelper

end
