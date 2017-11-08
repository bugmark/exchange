module DocfixIssuesHelper

  def docfix_issue_contracts(bug)
    lbl = case (count = bug.contracts.count)
      when 0 then "No Contracts"
      when 1 then "One Contract"
        else "#{count} Contracts"
    end
    raw "<h4>#{lbl}</h4>"
  end

  def docfix_issue_offers(bug)
    lbl = case (count = bug.offers.count)
      when 0 then "No Offers"
      when 1 then "One Offer"
      else "#{count} Offers"
    end
    raw "<h4>#{lbl}</h4>"
  end
end
