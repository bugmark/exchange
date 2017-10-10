module BidsHelper
  def bid_id_link(bid)
    raw "<a href='/core/bids/#{bid.id}'>#{bid.xid}</a>"
  end

  def bid_type_link(bid)
    type = bid.xtype
    raw "<a href='/core/bids/#{bid.id}'>#{type}</a>"
  end

  def bid_attach_link(bid)
    type = bid.attach_type
    obj  = bid.attach_obj
    raw "<a href='/core/#{type}/#{obj.id}'>#{obj.xid}</a>"
  end

  # ----- actions

  def bid_cancel_link(ask)
    nil
  end

  def bid_take_link(bid)
    status = bid.status
    if bid.unmatured? && status == "open"
      path = "/core/bids/#{bid.id}/edit"
      raw "<a href='#{path}'>Take</a>"
    else
      nil
    end
  end

  def bid_actions(bid)
    canc  = bid_cancel_link(bid)
    take  = bid_take_link(bid)
    return "NA" unless [take, canc].any?
    raw [canc, take].select(&:present?).join(" | ")
  end

  # -----

  def bid_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def bid_mature_date(bid)
    color = Time.now > bid.bid_maturation ? "red" : "green"
    date = bid.bid_maturation_str
    raw "<span style='color: #{color};'>#{date}</span>"
  end

  def bid_status(bid)
    case bid.status
      when "open"     then raw "<i class='fa fa-unlock'></i> open"
      when "taken"    then raw "<i class='fa fa-lock'></i> taken"
      when "awarded"  then raw "<i class='fa fa-check'></i> awarded"
      when "lapsed"   then raw "<i class='fa fa-check'></i> lapsed"
        else "UNKNOWN_CONTRACT_STATE"
    end
  end

  def bid_resolve_link(bid)
    return nil if bid.resolved?
    return nil unless bid.matured?
    link_to "Resolve", {:action => :resolve, :id => bid.id}
  end

  def bid_awardee(bid)
    icon, lbl = if bid.resolved?
      usr = bid.awardee_user
      lbl = "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
      ["check", lbl]
    else
      ["gears", bid.awardee]
    end
    raw "<i class='fa fa-#{icon}'></i> #{lbl}"
  end

  def bid_counterparty_link(bid)
    return "NA" unless bid.counterparty_id
    usr  = bid.counterparty
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end
end
