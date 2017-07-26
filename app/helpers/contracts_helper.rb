module ContractsHelper
  def contract_id_link(contract)
    raw "<a href='/contracts/#{contract.id}'>#{contract.id}</a>"
  end

  def contract_type_link(contract)
    type = contract.type.gsub("Contract::", "")
    raw "<a href='/contracts/#{contract.id}'>#{type}</a>"
  end

  def contract_attach_link(contract)
    id   = contract.bug_id || contract.repo_id
    type = contract.bug_id ? "bugs" : "repos"
    raw "<a href='/#{type}/#{id}'>#{type[0..-2].capitalize} #{id}</a>"
  end

  def contract_take_link(contract)
    status = contract.status
    if status == "open"
      path = "/contracts/#{contract.id}/edit"
      raw "<a href='#{path}'>take</a>"
    else
      "NA"
    end
  end

  def contract_publisher_link(contract)
    pid  = contract.publisher_id
    path = "/users/#{pid}"
    raw "<a href='#{path}'>#{pid}</a>"
  end

  def contract_counterparty_link(contract)
    return "NA" unless contract.counterparty_id
    pid  = contract.counterparty_id
    path = "/users/#{pid}"
    raw "<a href='#{path}'>#{pid}</a>"
  end
end
