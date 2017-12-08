require "ext/bucket_hash"

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
    lbl = case (count = bug.offers.open.count)
      when 0 then "No Open Offers"
      when 1 then "One Open Offer"
      else "#{count} Open Offers"
    end
    raw "<h4>#{lbl}</h4>"
  end

  # -----

  def docfix_issue_ou_vol(bug, period)
    date   = BugmTime.future_week_ends[period]
    offers = docfix_base_offers(bug, date).is_unfixed
    docfix_issue_values(offers)
  end

  def docfix_issue_of_vol(bug, period)
    date   = BugmTime.future_week_ends[period]
    offers = docfix_base_offers(bug, date).is_fixed
    docfix_issue_values(offers)
  end

  def docfix_base_offers(bug, date)
    bug.offers.open.overlaps_date(date)
  end

  def docfix_issue_values(offers)
    bucket = ::BucketHash.new (0.1..0.9).step(0.1)
    offers.reduce(bucket) do |acc, obj|
      acc.increment(obj.price, obj.volume)
    end.hash.values.join(",")
  end

  # ----- issue buttons -----

  def docfix_issue_first_btn(bug)
    raw <<-HTML.strip_heredoc
    <a class='btn btn-secondary gbtn' style='margin: 5px;' href='/docfix/issues/#{bug.id}/offer_buy'>
      <b>BE THE FIRST TO INVEST</b><br/><small>on the fixed or unfixed side</small>
    </a>
    HTML
  end

  def docfix_issue_bf_btn(bug)
    raw <<-HTML.strip_heredoc
    <a class='btn btn-secondary gbtn' style='margin: 5px;' href='/docfix/issues/#{bug.id}/offer_bf'>
      <b>CONTRIBUTE TO FIX</b><br/><small>buy fixed side</small>
    </a>
    HTML
  end

  def docfix_issue_bu_btn(bug)
    raw <<-HTML.strip_heredoc
    <a class='btn btn-secondary gbtn' style='margin: 5px;' href='/docfix/issues/#{bug.id}/offer_bu'>
      <b>INVEST IN FIX</b><br/><small>buy unfixed side</small>
    </a>
    HTML
  end

  def docfix_issue_action_btns(bug)
    return docfix_issue_first_btn(bug) unless bug.has_contracts? || bug.has_offers?
    docfix_issue_bu_btn(bug) + docfix_issue_bf_btn(bug)
  end
end
