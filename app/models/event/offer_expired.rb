require "ext/hash"

class Event::OfferExpired < Event

  jsonb_fields_for :payload, Offer

  validates :uuid, presence: true

  private

  def cast_object
    offer = Offer.find_by_uuid(uuid)
    offer.status = "expired"
    offer
  end

  def tgt_user_uuids
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
