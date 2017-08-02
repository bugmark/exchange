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
