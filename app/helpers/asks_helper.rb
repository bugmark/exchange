module AsksHelper
  def ask_id_link(ask)
    raw "<a href='/asks/#{ask.id}'>#{ask.xid}</a>"
  end

  def ask_type_link(ask)
    type = ask.xtype
    raw "<a href='/asks/#{ask.id}'>#{type}</a>"
  end

  def ask_attach_link(ask)
    type = ask.attach_type
    obj  = ask.attach_obj
    raw "<a href='/#{type}/#{obj.id}'>#{obj.xid}</a>"
  end

  def ask_take_link(ask)
    status = ask.status
    if ask.unmatured? && status == "open"
      path = "/asks/#{ask.id}/edit"
      raw "<a href='#{path}'>Take</a>"
    else
      nil
    end
  end

  def ask_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end

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
    return nil unless ask.matured?
    link_to "Resolve", {:action => :resolve, :id => ask.id}
  end

  def ask_actions(ask)
    take  = ask_take_link(ask)
    resv  = ask_resolve_link(ask)
    return "NA" unless [take, resv].any?
    raw [take, resv].select(&:present?).join(" | ")
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
