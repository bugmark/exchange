module CorePositionsHelper

  def core_position_link(position)
    raw "<a href='/core/positions/#{position.id}'>#{position.xid}</a>"
  end

  # ----- actions -----

  def core_position_sell_link(position)
    if current_user.present? && position.user.id == current_user.id
      raw "<a href='/core/sell_offers/new?position_id=#{position.id}'>sell</a>"
    else
      nil
    end
  end

  def core_position_actions(position)
      sell  = core_position_sell_link(position)
      list = [sell]
      return "NA" unless list.any?
      raw list.select(&:present?).join(" | ")
  end

end
