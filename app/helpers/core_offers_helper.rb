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
    raw "<a href='/core/#{offer.side}s/#{offer.id}'>#{offer.xid}</a>"
  end

  def core_offer_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/core/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def core_offer_attach_link(offer)
    type = offer.attach_type
    obj  = offer.attach_obj
    raw "<a href='/core/#{type}/#{obj.id}'>#{obj.xid}</a>"
  end

  # ----- actions -----

  def core_offer_cross_link(offer)
    nil
  end

  def core_offer_retract_link(offer)
    raw "<a href='/core/offers/#{offer.id}/retract' data-confirm='Are you sure?'>Retract</a>"
  end

  def core_offer_take_link(offer)
    status = offer.status
    if offer.is_unmatured? && status == "open"
      path = "/core/bids/#{offer.id}/edit"
      raw "<a href='#{path}'>Take</a>"
    else
      nil
    end
  end

  def core_offer_actions(offer)
    cros  = core_offer_cross_link(offer)
    canc  = core_offer_retract_link(offer)
    take  = core_offer_take_link(offer)
    return "NA" unless [cros, take, canc].any?
    raw [canc, take, cros].select(&:present?).join(" | ")
  end
end
