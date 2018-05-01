module CoreIssuesHelper
  def core_issue_id_link(issue)
    raw "<a href='/core/issues/#{issue.uuid}'>#{issue.xid}</a>"
  end

  def core_issue_title_link(issue)
    title = truncate(issue.stm_title)
    # raw "<a href='/issues/#{issue.id}'>#{title}</a>"
    title
  end

  def core_issue_repo_link(issue, filter)
    repo = issue.repo
    uuid = repo.uuid
    name = repo.name
    l1   = "<a href='/core/issues?stm_repo_uuid=#{uuid}'><i class='fa fa-filter'></i></a> | "
    l2   = "<a href='/core/repos/#{uuid}'>#{name}</a>"
    raw (filter.nil? ? l1 + l2 : l2)
  end

  def core_issue_offer_link(issue)
    count = issue.offers.open.count
    if count > 0
      raw "<a class='offerlink' href='/core/offers?stm_issue_uuid=#{issue.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_issue_contract_link(issue)
    count = issue.contracts.count
    if count > 0
      raw "<a class='contractlink' href='/core/contracts?stm_issue_uuid=#{issue.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_issue_bids_link(issue)
    # issue.bids.count
    ""
  end

  def core_issue_asks_link(issue)
    # issue.asks.count
    ""
  end

  def core_issue_fixed_new_link(issue)
    path = "/core/offers_bf/new?type=git_hub&stm_issue_uuid=#{issue.uuid}"
    raw "<a href='#{path}'>fixed</a>"
  end

  def core_issue_unfixed_new_link(issue)
    path = "/core/offers_bu/new?type=git_hub&stm_issue_uuid=#{issue.uuid}"
    raw "<a href='#{path}'>unfixed</a>"
  end

  def core_issue_actions(issue)
    cbid = core_issue_unfixed_new_link(issue)
    cask = core_issue_fixed_new_link(issue)
    raw [cbid,cask].select(&:present?).join(" | ")
  end

  def core_issue_http_link(issue)
    url = issue.html_url
    lbl = url&.gsub("https://github.com/", "")
    if url.nil?
      "NA"
    else
      raw "<a href='#{url}' target='_blank'>#{lbl}</a>"
    end
  end
end
