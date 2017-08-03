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
    if status == "open"
      path = "/contracts/#{contract.id}/edit"
      raw "<a href='#{path}'>Take</a>"
    else
      "NA"
    end
  end

  def contract_user_link(usr)
    return "NA" if usr.nil?
    raw "<a href='/users/#{usr.id}'>#{usr.xid}</a>"
  end

  def contract_mature_date(contract)
    color = Time.now > contract.matures_at ? "red" : "green"
    date = contract.matures_at.strftime("%b-%d %H:%M:%S")
    raw "<span style='color: #{color};'>#{date}</span>"
  end

  def contract_status(contract)
    case contract.status
      when "open"     then raw "<i class='fa fa-unlock'></i> open"
      when "taken"    then raw "<i class='fa fa-lock'></i> taken"
      when "lapsed"   then raw "<i class='fa fa-close'></i> lapsed"
      when "resolved" then raw "<i class='fa fa-check'></i> resolved"
    end
  end

  def contract_awardee(contract)
    states = %w(lapsed resolved)
    icon = states.include?(contract.status) ? "check" : "gears"
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
