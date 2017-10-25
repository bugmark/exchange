module CoreOffersHelper
  def core_offer_header(filter)
    return "All Offers" if filter.nil?
    lbls = {"stm_repo_id" => "Repo", "stm_bug_id" => "Bug", "user_id" => "User"}
    lbl  = lbls[filter.key]
    all_link = "<a href='/core/offers'>All Offers</a>"
    obj_link = "<a href='/core/#{lbl.downcase}s/#{filter.obj.id}'>#{lbl} #{filter.obj.id}</a>"
    raw "Offers for #{obj_link} | #{all_link}"
  end

  def core_offer_id_link(offer)
    raw "<a href='/core/offers/#{offer.id}'>#{offer.xid}</a>"
  end

  def core_offer_user_link(offer)
    return "NA" unless offer.respond_to?(:user)
    usr = offer.user
    return "NA" if offer.nil? || usr.nil?
    raw "<a href='/core/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def core_offer_attach_link(offer)
    type = offer.attach_type
    obj  = offer.attach_obj
    raw "<a href='/core/#{type}/#{obj.id}'>#{obj.xid}</a>"
  end

  def core_sell_offer_new_link(position_id)
    raw "<a href='/core/sell_offers/new?position_id=#{position_id}'>sell</a>"
  end

  # ----- actions -----

  def core_offer_take_link(offer)
    if offer.status == "open" && current_user.present?
      path = "/core/offers/#{offer.id}/take"
      raw "<a href='#{path}'>take</a>"
    else
      nil
    end
  end

  def core_offer_cross_link(offer)
    if offer.status == "open"
      path = "/core/offers/#{offer.id}/cross"
      raw "<a href='#{path}'>cross</a>"
    else
      nil
    end
  end

  def core_offer_retract_link(offer)
    if offer.status == "open" && current_user.present? && offer.user.id == current_user.id
      raw "<a href='/core/offers/#{offer.id}/retract' data-confirm='Are you sure?'>retract</a>"
    else
      nil
    end
  end

  def core_offer_actions(offer)
    cros  = core_offer_cross_link(offer)
    canc  = core_offer_retract_link(offer)
    take  = core_offer_take_link(offer)
    return "NA" unless [cros, take, canc].any?
    raw [take, cros, canc].select(&:present?).join(" | ")
  end
end
