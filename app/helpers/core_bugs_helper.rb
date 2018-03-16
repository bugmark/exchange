module CoreBugsHelper
  def core_issue_id_link(bug)
    raw "<a href='/core/bugs/#{bug.uuid}'>#{bug.xid}</a>"
  end

  def core_bug_title_link(bug)
    title = truncate(bug.stm_title)
    # raw "<a href='/bugs/#{bug.id}'>#{title}</a>"
    title
  end

  def core_bug_repo_link(bug, filter)
    repo = bug.repo
    uuid = repo.uuid
    name = repo.name
    l1   = "<a href='/core/bugs?stm_repo_uuid=#{uuid}'><i class='fa fa-filter'></i></a> | "
    l2   = "<a href='/core/repos/#{uuid}'>#{name}</a>"
    raw (filter.nil? ? l1 + l2 : l2)
  end

  def core_bug_offer_link(bug)
    count = bug.offers.open.count
    if count > 0
      raw "<a class='offerlink' href='/core/offers?stm_issue_uuid=#{bug.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_bug_contract_link(bug)
    count = bug.contracts.count
    if count > 0
      raw "<a class='contractlink' href='/core/contracts?stm_issue_uuid=#{bug.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_bug_bids_link(bug)
    # bug.bids.count
    ""
  end

  def core_bug_asks_link(bug)
    # bug.asks.count
    ""
  end

  def core_bug_fixed_new_link(bug)
    path = "/core/offers_bf/new?type=git_hub&stm_issue_uuid=#{bug.uuid}"
    raw "<a href='#{path}'>fixed</a>"
  end

  def core_bug_unfixed_new_link(bug)
    path = "/core/offers_bu/new?type=git_hub&stm_issue_uuid=#{bug.uuid}"
    raw "<a href='#{path}'>unfixed</a>"
  end

  def core_bug_actions(bug)
    cbid = core_bug_unfixed_new_link(bug)
    cask = core_bug_fixed_new_link(bug)
    raw [cbid,cask].select(&:present?).join(" | ")
  end

  def core_bug_http_link(bug)
    url = bug.html_url
    lbl = url&.gsub("https://github.com/", "")
    if url.nil?
      "NA"
    else
      raw "<a href='#{url}' target='_blank'>#{lbl}</a>"
    end
  end
end
