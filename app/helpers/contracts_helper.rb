module ContractsHelper
  def contract_take_link(contract)
    status = contract.status
    if status == "open"
      path = "/contracts/#{contract.id}/edit"
      raw "<a href='#{path}'>take</a>"
    else
      status
    end
  end
end
