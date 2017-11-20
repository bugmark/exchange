module CorePositionsHelper

  def core_position_link(position)
    return "NA" if position.nil?
    raw "<a href='/core/positions/#{position.id}'>#{position.xid}</a>"
  end

  def core_resell_position_link(offer)
    return "NA" if offer.nil?
    parent = offer.salable_position
    return "NA" if parent.nil?
    raw "<a href='/core/positions/#{parent.id}'>#{parent.xid}</a>"
  end

  # ----- actions -----

  def core_position_sell_link(position)
    return nil if     Time.now > position.contract.maturation
    return nil unless current_user.present?
    return nil unless position.user.id == current_user.id
    raw "<a href='/core/sell_offers/new?position_id=#{position.id}'>sell</a>"
  end

  def core_position_actions(position)
      sell  = core_position_sell_link(position)
      list = [sell]
      return "NA" unless list.any?
      raw list.select(&:present?).join(" | ")
  end

end
