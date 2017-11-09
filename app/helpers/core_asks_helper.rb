module CoreAsksHelper
  def ask_id_link(ask)
    raw "<a href='/core/asks/#{ask.id}'>#{ask.xid}</a>"
  end

  def ask_type_link(ask)
    type = ask.xtype
    raw "<a href='/core/asks/#{ask.id}'>#{type}</a>"
  end

  def ask_attach_link(ask)
    return ""
    # type = ask.attach_type
    # obj  = ask.attach_obj
    # raw "<a href='/core/#{type}/#{obj.id}'>#{obj.xid}</a>"
  end

  def core_ask_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def ask_cross_count(ask)
    return ""
    # count = ask.matching_bids.count
    # return count if count == 0
    # value = ask.matching_bid_reserve
    # "#{count} (#{value} tokens)"
  end

  # ----- actions

  def ask_cancel_link(ask)
    nil
  end

  def ask_take_link(ask)
    nil
  end

  # TODO: fixme
  # def ask_cross_link(ask)
  #   return nil
  #   return nil if ask.matching_bid_reserve < ask.price
  #   raw "<a href='/core/offers/#{ask.id}/cross'>cross</a>"
  # end

  def ask_actions(ask)
    canc  = ask_cancel_link(ask)
    take  = ask_take_link(ask)
    cros  = ask_cross_link(ask)
    return "NA" unless [canc, take, cros].any?
    raw [canc, take, cros].select(&:present?).join(" | ")
  end

  # -----

  def ask_mature_date(ask)
    color = Time.now > ask.ask_maturation ? "red" : "green"
    date = ask.ask_maturation_str
    raw "<span style='color: #{color};'>#{date}</span>"
  end

  def ask_status(ask)
    case ask.status
      when "open"     then raw "<i class='fa fa-unlock'></i> open"
      when "taken"    then raw "<i class='fa fa-lock'></i> taken"
      when "awarded"  then raw "<i class='fa fa-check'></i> awarded"
      when "lapsed"   then raw "<i class='fa fa-check'></i> lapsed"
        else "UNKNOWN_CONTRACT_STATE"
    end
  end

  def ask_resolve_link(ask)
    return nil if ask.resolved?
    return nil unless ask.is_matured?
    link_to "Resolve", {:action => :resolve, :id => ask.id}
  end

  def ask_awardee(ask)
    icon, lbl = if ask.resolved?
      usr = ask.awardee_user
      lbl = "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
      ["check", lbl]
    else
      ["gears", ask.awardee]
    end
    raw "<i class='fa fa-#{icon}'></i> #{lbl}"
  end

  def ask_counterparty_link(ask)
    return "NA" unless ask.counterparty_id
    usr  = ask.counterparty
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end
end
