class Event::OfferBuyCreated < Event

  jsonb_accessor :data, "user_uuid"  => :string
  jsonb_accessor :data, "volume"     => :integer
  jsonb_accessor :data, "price"      => :float
  jsonb_accessor :data, "aon"        => [:boolean, default: false]
  jsonb_accessor :data, "poolable"   => [:boolean, default: false]

  validates :uuid , presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  def cast_transaction
    opts = {"uuid" => uuid, "email" => email, "encrypted_password" => encrypted_password}
    User.create(opts)
    offer_klas.create(opts)
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
