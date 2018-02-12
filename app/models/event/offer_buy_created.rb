require "ext/hash"

class Event::OfferBuyCreated < Event

  EXTRAS = {
    "maturation"     => :datetime,
    "maturation_beg" => :datetime,
    "maturation_end" => :datetime
  }

  jsonb_fields_for :payload, Offer, {extras: EXTRAS}

  validates :uuid     , presence: true
  validates :user_uuid, presence: true
  validates :volume   , presence: true
  validates :price    , presence: true

  before_validation :set_defaults

  def influx_tags
    {
      side:     offer.side       ,
      intent:   offer.intent     ,
      poolable: offer.poolable   ,
      aon:      offer.aon
    }
  end

  def influx_fields
    {
      id:             offer.id                                     ,
      volume:         offer.volume                                 ,
      price:          offer.price                                  ,
      stm_issue_uuid: offer.stm_issue_uuid                         ,
      stm_repo_uuid:  offer.stm_repo_uuid || offer.issue.repo.uuid ,
      stm_status:     offer.stm_status
    }.delete_if {|_k, v| v.nil?}
  end

  private

  def offer
    klas = payload['type'].constantize
    @off ||= klas.new(payload)
  end

  def cast_object
    offer
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
