module DocfixIssuesHelper

  def docfix_issue_why_would_i(bug)
    return "" unless bug.has_contracts? || bug.has_offers?
    raw "<i class='fa fa-question-circle'></i> Why would I do this?"
  end

  def docfix_issue_status_badge(bug)
    lbl = case (bug.stm_status)
      when "open" then "UNFIXED"
      when "closed" then "FIXED"
      else "STATUS-TBD"
    end
    raw "<span class='badge badge-default'>#{lbl}</span>"
  end

  def docfix_issue_comments(bug)
    return "" if bug.comments.blank? || bug.comments.nil?
    text = bug.comments.gsub("\n", "<br/>")
    text.length < 400 ? raw(text) : raw(text[0..400] + "...")
  end

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

  # ----- issue buttons -----

  def docfix_issue_first_btn(bug)
    raw """
    <a class='btn btn-secondary' style='width: 100%; margin: 5px;' href='/docfix/issues/#{bug.id}/offer_buy'>
    <b>BE THE FIRST TO INVEST</b><br/><small>on the fixed or unfixed side</small>
    </button>
    """
  end

  def docfix_issue_bf_btn(bug)
    raw """
    <a class='btn btn-secondary' style='width: 100%; margin: 5px;' href='/docfix/issues/#{bug.id}/offer_bf'>
    <b>CONTRIBUTE TO FIX</b><br/><small>buy fixed side</small>
    </button>
    """
  end

  def docfix_issue_bu_btn(bug)
    raw """
    <a class='btn btn-secondary' style='width: 100%; margin: 5px;' href='/docfix/issues/#{bug.id}/offer_bu'>
    <b>INVEST IN FIX</b><br/><small>buy unfixed side</small>
    </button>
    """
  end

  def docfix_issue_action_btns(bug)
    return docfix_issue_first_btn(bug) unless bug.has_contracts? || bug.has_offers?
    docfix_issue_bu_btn(bug) + docfix_issue_bf_btn(bug)
  end
end
