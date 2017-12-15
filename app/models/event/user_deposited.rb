class Event::UserDeposited < Event

  jsonb_accessor :data, "uuid"   => :string
  jsonb_accessor :data, "amount" => :float

  validates :uuid   , presence: true
  validates :amount , presence: true

  def cast_transaction
    user = User.find_by_uuid(uuid)
    user.balance += amount
    user.save
    user
  end

  def email() "" end   # TODO: GET RID OF THIS

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
