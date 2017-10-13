module BugsHelper
  def bug_id_link(bug)
    raw "<a href='/core/bugs/#{bug.id}'>#{bug.xid}</a>"
  end

  def bug_title_link(bug)
    title = truncate(bug.title)
    # raw "<a href='/bugs/#{bug.id}'>#{title}</a>"
    title
  end

  def bug_repo_link(bug, filter)
    repo = bug.repo
    id   = repo.id
    name = repo.name
    l1   = "<a href='/core/bugs?repo_id=#{id}'><i class='fa fa-filter'></i></a> | "
    l2   = "<a href='/core/repos/#{id}'>#{name}</a>"
    raw (filter.nil? ? l1 + l2 : l2)
  end

  def bug_contract_link(bug)
    count = bug.contracts.count
    if count > 0
      raw "<a href='/core/rewards?bug_id=#{bug.id}'>#{count}</a>"
    else
      count
    end
  end

  def bug_bids_link(bug)
    bug.bids.count
  end

  def bug_asks_link(bug)
    bug.asks.count
  end

  # def bug_contract_new_link(bug)
  #   path = "/contracts/new?type=git_hub&bug_id=#{bug.id}"
  #   raw "<a href='#{path}'>Contract</a>"
  # end

  def bug_ask_new_link(bug)
    path = "/core/asks/new?type=git_hub&bug_id=#{bug.id}"
    raw "<a href='#{path}'>Ask</a>"
  end

  def bug_bid_new_link(bug)
    path = "/core/bids/new?type=git_hub&bug_id=#{bug.id}"
    raw "<a href='#{path}'>Bid</a>"
  end

  def bug_actions(bug)
    cbid = bug_bid_new_link(bug)
    cask = bug_ask_new_link(bug)
    raw [cbid,cask].select(&:present?).join(" | ")
  end

  def bug_http_link(bug)
    url = bug.html_url
    if url.nil?
      "NA"
    else
      raw "<a href='#{url}' target='_blank'>#{url}</a>"
    end
  end
end
