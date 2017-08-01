module BugsHelper
  def bug_id_link(bug)
    raw "<a href='/bugs/#{bug.id}'>#{bug.id}</a>"
  end

  def bug_title_link(bug)
    title = truncate(bug.title)
    raw "<a href='/bugs/#{bug.id}'>#{title}</a>"
  end

  def bug_repo_link(bug, filter)
    repo = bug.repo
    id   = repo.id
    name = repo.name
    l1   = "<a href='/bugs?repo_id=#{id}'><i class='fa fa-filter'></i></a> | "
    l2   = "<a href='/repos/#{id}'>#{name}</a>"
    dev_log filter
    raw (filter.nil? ? l1 + l2 : l2)
  end

  def bug_contract_link(bug)
    count = bug.contracts.count
    if count > 0
      raw "<a href='/contracts?bug_id=#{bug.id}'>#{count}</a>"
    else
      count
    end
  end

  def bug_contract_new_link(bug)
    path = "/contracts/new?type=forecast&bug_id=#{bug.id}"
    raw "<a href='#{path}'>Contract</a>"
  end

  def bug_reward_link(bug)
    path = "contracts/new?type=reward&bug_id=#{bug.id}"
    raw "<a href='#{path}'>Reward</a>"
  end
end
