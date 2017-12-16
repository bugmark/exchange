require 'ext/hash'

class Event::UserCreated < Event

  jsonb_accessor :data, "uuid"  => :string
  jsonb_accessor :data, "email" => :string
  jsonb_accessor :data, "encrypted_password" => :string

  validates :uuid , presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  def cast_object
    User.new(data.without_blanks)
  end

  def user_uuids
    [uuid]
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string
#  uuid         :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  data         :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
