class Event::DpBaseLogged < Event

  after_initialize :set_payload

  def set_payload
    self.payload = lcl_payload
  end

  def cast_object
    ArProxy.new
  end

  def influx_fields
    lcl_payload
  end

  # don't know who is calling this...
  def uuid
    "TBD"
  end

  private

  def lcl_payload
    @lcl_payload ||= {
      num_users:  User.count                     ,
      num_repos:  Repo.count                     ,
      num_issues: Issue.count                    ,
      num_offers: Offer.count                    ,
      bf_offers:  Offer::Buy::Fixed.open.count   ,
      bu_offers:  Offer::Buy::Unfixed.open.count ,
      contracts:  Contract.open.count            ,
      positions:  Position.count                 ,
      escrows:    Escrow.count                   ,
      amendments: Amendment.count                ,
      events:     Event.count
    }
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
