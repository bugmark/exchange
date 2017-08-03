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
    count  = repo.contracts.count
    blbl   = repo.bug_contracts.count > 0 ? "*" : ""
    if count > 0
      raw "<a href='/contracts?repo_id=#{repo.id}'>#{count}</a> #{blbl}"
    else
      "0 #{blbl}"
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

  def repo_destroy_link(repo)
    return nil if repo.has_contracts?
    link_to 'Destroy', { action: :destroy, id: repo.id }, method: :delete, data: { confirm: 'Are you sure?' }
  end

  def repo_actions(repo)
    cnew  = repo_contract_new_link(repo)
    csync = link_to "Sync", {:action => :sync, :id => repo.id}
    cdest = repo_destroy_link(repo)
    raw [cnew,csync,cdest].select(&:present?).join(" | ")
  end

  def repo_http_link(repo)
    url = repo.html_url
    raw "<a href='#{url}' target='_blank'>#{url}</a>"
  end
end
