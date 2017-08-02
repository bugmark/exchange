module ReposHelper
  def repo_id_link(repo)
    raw "<a href='/repos/#{repo.id}'>#{repo.xid}</a>"
  end

  def repo_name_link(repo)
    truncate(repo.name)
  end

  def repo_contract_new_link(repo)
    path = "contracts/new?type=forecast&repo_id=#{repo.id}"
    raw "<a href='#{path}'>New Contract</a>"
  end

  def repo_contract_link(repo)
    count = repo.contracts.count
    if count > 0
      raw "<a href='/contracts?repo_id=#{repo.id}'>#{count}</a>"
    else
      count
    end
  end

  def repo_bug_link(repo)
    count = repo.bugs.count
    if count > 0
      raw "<a href='/bugs?repo_id=#{repo.id}'>#{count}</a>"
    else
      count
    end
  end
end
