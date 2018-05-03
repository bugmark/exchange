module CoreOffersHelper
  def core_statement_stats(obj)
    string = {
      "BugID"  => obj.stm_issue_uuid    ,
      "TrackerID" => obj.stm_tracker_uuid   ,
      "Title"  => obj.stm_title       ,
      "Status" => obj.stm_status      ,
      # "Labels" => obj.stm_labels    ,
    }.map {|x,y| "<u>#{x}</u>[#{y}]"}.join(" ")
    raw string
  end

  def core_offer_header(filter)
    return "All Offers" if filter.nil?
    lbls = {"stm_tracker_uuid" => "Tracker", "stm_issue_uuid" => "Bug", "user_uuid" => "User"}
    lbl  = lbls[filter.key]
    all_link = "<a href='/core/offers'>All Offers</a>"
    obj_link = "<a href='/core/#{lbl.downcase}s/#{filter.obj.id}'>#{lbl} #{filter.obj.id}</a>"
    raw "Offers for #{obj_link} | #{all_link}"
  end

  def core_offer_id_link(offer)
    raw "<a href='/core/offers/#{offer.uuid}'>#{offer.xid}</a>"
  end
  #
  # def core_offer_user_link(offer)
  #   return "NA" unless offer.respond_to?(:user)
  #   usr = offer.user
  #   return "NA" if offer.nil? || usr.nil?
  #   raw "<a href='/core/users/#{usr.id}'>#{usr.xid}</a>"
  # end

  def core_offer_attach_link(offer)
    type = offer.attach_type
    obj  = offer.attach_obj
    raw "<a href='/core/#{type}/#{obj&.uuid}'>#{obj&.xid}</a>"
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
    return nil unless offer.status == "open"
    return nil unless offer.has_counters?(:expand)
    path = "/core/offers/#{offer.id}/cross"
    raw "<a href='#{path}'>cross</a>"
  end

  def core_offer_cancel_link(offer)
    if offer.status == "open" && current_user.present? && offer.user.id == current_user.id
      raw "<a href='/core/offers/#{offer.id}/cancel' data-confirm='Are you sure?'>cancel</a>"
    else
      nil
    end
  end

  def core_offer_actions(offer)
    cros  = core_offer_cross_link(offer)
    canc  = core_offer_cancel_link(offer)
    take  = core_offer_take_link(offer)
    return "NA" unless [cros, take, canc].any?
    raw [take, cros, canc].select(&:present?).join(" | ")
  end
end
