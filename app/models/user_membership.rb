class UserMembership < ApplicationRecord

  with_options primary_key: "uuid" do
    belongs_to :user      , foreign_key: "user_uuid" , class_name: "User"
    belongs_to :group     , foreign_key: "group_uuid", class_name: "UserGroup"
  end
end

# == Schema Information
#
# Table name: user_memberships
#
#  id         :bigint(8)        not null, primary key
#  uuid       :string
#  user_uuid  :string
#  group_uuid :string
#
