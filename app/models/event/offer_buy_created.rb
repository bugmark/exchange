require "ext/hash"

class Event::OfferBuyCreated < Event

  jsonb_accessor :payload, "type"           => :string
  jsonb_accessor :payload, "uuid"           => :string
  jsonb_accessor :payload, "user_uuid"      => :string
  jsonb_accessor :payload, "volume"         => :integer
  jsonb_accessor :payload, "price"          => :float
  jsonb_accessor :payload, "aon"            => [:boolean, default: false]
  jsonb_accessor :payload, "poolable"       => [:boolean, default: false]
  jsonb_accessor :payload, "maturation"     => :datetime
  jsonb_accessor :payload, "maturation_min" => :datetime
  jsonb_accessor :payload, "maturation_max" => :datetime
  jsonb_accessor :payload, "stm_bug_id"     => :string
  jsonb_accessor :payload, "stm_repo_id"    => :string
  jsonb_accessor :payload, "stm_title"      => :string
  jsonb_accessor :payload, "stm_status"     => :string
  jsonb_accessor :payload, "stm_labels"     => :string

  validates :uuid     , presence: true
  validates :user_uuid, presence: true
  validates :volume   , presence: true
  validates :price    , presence: true

  def user=(user) @user = user end
  def user()      @user        end

  private

  def cast_object
    klas = payload['type'].constantize
    klas.new(valid_payload)
  end

  def valid_payload
    payload[:user_uuid] ||= user&.uuid
    payload[:status]      = 'open'
    payload.without_blanks
  end

  def user_uuids
    [user_uuid]
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
