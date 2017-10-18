module CoreBugsHelper
  def core_bug_id_link(bug)
    raw "<a href='/core/bugs/#{bug.id}'>#{bug.xid}</a>"
  end

  def core_bug_title_link(bug)
    title = truncate(bug.stm_title)
    # raw "<a href='/bugs/#{bug.id}'>#{title}</a>"
    title
  end

  def core_bug_repo_link(bug, filter)
    repo = bug.repo
    id   = repo.id
    name = repo.name
    l1   = "<a href='/core/bugs?stm_repo_id=#{id}'><i class='fa fa-filter'></i></a> | "
    l2   = "<a href='/core/repos/#{id}'>#{name}</a>"
    raw (filter.nil? ? l1 + l2 : l2)
  end

  def core_bug_offer_link(bug)
    count = bug.offers.count
    if count > 0
      raw "<a class='offerlink' href='/core/offers?stm_bug_id=#{bug.id}'>#{count}</a>"
    else
      count
    end
  end

  def core_bug_contract_link(bug)
    count = bug.contracts.count
    if count > 0
      raw "<a class='contractlink' href='/core/contracts?stm_bug_id=#{bug.id}'>#{count}</a>"
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

  # def bug_contract_new_link(bug)
  #   path = "/contracts/new?type=git_hub&bug_id=#{bug.id}"
  #   raw "<a href='#{path}'>Contract</a>"
  # end

  def core_bug_ask_new_link(bug)
    path = "/core/asks/new?type=git_hub&stm_bug_id=#{bug.id}"
    raw "<a href='#{path}'>Ask</a>"
  end

  def core_bug_bid_new_link(bug)
    path = "/core/bids/new?type=git_hub&stm_bug_id=#{bug.id}"
    raw "<a href='#{path}'>Bid</a>"
  end

  def core_bug_actions(bug)
    cbid = core_bug_bid_new_link(bug)
    cask = core_bug_ask_new_link(bug)
    raw [cbid,cask].select(&:present?).join(" | ")
  end

  def core_bug_http_link(bug)
    url = bug.html_url
    if url.nil?
      "NA"
    else
      raw "<a href='#{url}' target='_blank'>#{url}</a>"
    end
  end
end
