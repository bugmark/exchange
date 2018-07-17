class UserGroup < ApplicationRecord

  with_options primary_key: "uuid" do
    belongs_to :owner      , foreign_key: "owner_uuid", class_name: "User"
    has_many   :memberships, foreign_key: "user_uuid" , class_name: "UserMembership"
  end
  has_many   :users      , :through => :memberships

end

# == Schema Information
#
# Table name: user_groups
#
#  id         :bigint(8)        not null, primary key
#  uuid       :string
#  owner_uuid :string
#  name       :string
#  tags       :string
#  jfields    :jsonb            not null
#  status     :string           default("open")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
