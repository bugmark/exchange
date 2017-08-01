module BugsHelper
  def bug_id_link(bug)
    raw "<a href='/bugs/#{bug.id}'>#{bug.id}</a>"
  end

  def bug_title_link(bug)
    truncate(bug.title)
  end

  def bug_repo_link(bug)
    repo = bug.repo
    id   = repo.id
    name = repo.name
    raw "<a href='/bugs?repo_id=#{id}'>#{name}</a>"
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
