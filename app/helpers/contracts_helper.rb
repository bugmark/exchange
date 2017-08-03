module ContractsHelper
  def contract_id_link(contract)
    raw "<a href='/contracts/#{contract.id}'>#{contract.xid}</a>"
  end

  def contract_type_link(contract)
    type = contract.xtype
    raw "<a href='/contracts/#{contract.id}'>#{type}</a>"
  end

  def contract_attach_link(contract)
    type = contract.attach_type
    obj  = contract.attach_obj
    raw "<a href='/#{type}/#{obj.id}'>#{obj.xid}</a>"
  end

  def contract_take_link(contract)
    status = contract.status
    if contract.unmatured? && status == "open"
      path = "/contracts/#{contract.id}/edit"
      raw "<a href='#{path}'>Take</a>"
    else
      nil
    end
  end

  def contract_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def contract_mature_date(contract)
    color = Time.now > contract.matures_at ? "red" : "green"
    date = contract.matures_at_str
    raw "<span style='color: #{color};'>#{date}</span>"
  end

  def contract_status(contract)
    case contract.status
      when "open"     then raw "<i class='fa fa-unlock'></i> open"
      when "taken"    then raw "<i class='fa fa-lock'></i> taken"
      when "awarded"  then raw "<i class='fa fa-close'></i> awarded"
      when "lapsed"   then raw "<i class='fa fa-check'></i> lapsed"
        else "UNKNOWN_CONTRACT_STATE"
    end
  end

  def contract_resolve_link(contract)
    return nil if contract.resolved?
    return nil unless contract.matured?
    link_to "Resolve", {:action => :resolve, :id => contract.id}
  end

  def contract_actions(contract)
    take  = contract_take_link(contract)
    resv  = contract_resolve_link(contract)
    return "NA" unless [take, resv].any?
    raw [take, resv].select(&:present?).join(" | ")
  end

  def contract_awardee(contract)
    icon = contract.resolved? ? "check" : "gears"
    raw "<i class='fa fa-#{icon}'></i> #{contract.awardee}"
  end

  def contract_publisher_link(contract)
    usr  = contract.publisher
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def contract_counterparty_link(contract)
    return "NA" unless contract.counterparty_id
    usr  = contract.counterparty
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end
end
