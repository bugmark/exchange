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
    raw "<a href='/core/#{offer.xtag}s/#{offer.id}'>#{offer.xid}</a>"
  end

  def core_offer_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/core/users/#{usr.id}'>#{usr.xid}</a>"
  end

  # ----- actions -----

  def core_offer_cancel_link(_offer)
    nil
  end

  def core_offer_take_link(offer)
    status = offer.status
    if offer.unmatured? && status == "open"
      path = "/core/bids/#{offer.id}/edit"
      raw "<a href='#{path}'>Take</a>"
    else
      nil
    end
  end

  def core_offer_actions(offer)
    canc  = core_offer_cancel_link(offer)
    take  = core_offer_take_link(offer)
    return "NA" unless [take, canc].any?
    raw [canc, take].select(&:present?).join(" | ")
  end
end
