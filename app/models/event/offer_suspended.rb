require "ext/hash"

class Event::OfferSuspended < Event

  jsonb_fields_for :payload, Offer, {extras: {"maturation" => :datetime}}

  validates :uuid     , presence: true
  # validates :user_uuid, presence: true
  # validates :volume   , presence: true
  # validates :price    , presence: true

  # before_validation :set_defaults

  private

  def cast_object
    klas = payload['type'].constantize
    klas.new(payload)
  end

  def set_defaults
    payload["status"] ||= 'open'
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
