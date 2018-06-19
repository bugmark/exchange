require "ext/hash"

class Event::OfferSellCreated < Event

  EXTRAS = {
    "maturation"     => :datetime,
    "maturation_beg" => :datetime,
    "maturation_end" => :datetime
  }

  jsonb_fields_for :payload, Offer, {extras: EXTRAS}

  validates :uuid                  , presence: true
  validates :user_uuid             , presence: true
  validates :volume                , presence: true
  validates :price                 , presence: true
  validates :salable_position_uuid , presence: true

  before_validation :set_defaults

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
#  id           :bigint(8)        not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  tags         :string           default([]), is an Array
#  note         :string
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
