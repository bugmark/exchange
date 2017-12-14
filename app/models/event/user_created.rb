class Event::UserCreated < Event

  jsonb_accessor :data, :uuref => :string
  jsonb_accessor :data, :email => :string
  jsonb_accessor :data, :encrypted_password => :string

  validates :uuref, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  def cast_transaction
    opts = {uuref: uuref, email: email, encrypted_password: encrypted_password}
    User.create(opts)
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string
#  uuref        :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  data         :jsonb            not null
#  jfields      :jsonb            not null
#  user_ids     :integer          default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
