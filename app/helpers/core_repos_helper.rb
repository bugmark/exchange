module CoreReposHelper
  def core_repo_id_link(repo)
    raw "<a href='/core/repos/#{repo.uuid}'>#{repo.xid}</a>"
  end

  def core_repo_name_link(repo)
    truncate(repo.name)
  end

  def core_repo_offer_bu_new_link(repo)
    path = "/core/offers_bu/new?type=git_hub&stm_repo_uuid=#{repo.uuid}"
    raw "<a href='#{path}'>unfixed</a>"
  end

  def core_repo_offer_bf_new_link(repo)
    path = "/core/offers_bf/new?type=git_hub&stm_repo_uuid=#{repo.uuid}"
    raw "<a href='#{path}'>fixed</a>"
  end

  def core_repo_bug_link(repo)
    count = repo.bugs.count
    if count > 0
      raw "<a class='buglink' href='/core/bugs?stm_repo_uuid=#{repo.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_repo_offer_link(repo)
    count = repo.offers.open.count
    if count > 0
      raw "<a class='offerlink' href='/core/offers?stm_repo_uuid=#{repo.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_repo_contract_link(repo)
    count  = repo.contracts.count
    if count > 0
      raw "<a class='contractlink' href='/core/contracts?stm_repo_uuid=#{repo.uuid}'>#{count}</a>"
    else
      count
    end
  end

  def core_repo_destroy_link(repo)
    return nil if repo.has_contracts?
    link_to 'Destroy', { action: :destroy, id: repo.uuid }, method: :delete, data: { confirm: 'Are you sure?' }
  end

  def repo_actions(repo)
    cbid  = core_repo_offer_bu_new_link(repo)
    cask  = core_repo_offer_bf_new_link(repo)
    csync = link_to "Sync", {:action => :sync, :id => repo.uuid}
    cdest = core_repo_destroy_link(repo)
    # TODO: add sync and destroy
    # raw [cbid,cask,csync,cdest].select(&:present?).join(" | ")
    raw [cbid,cask].select(&:present?).join(" | ")
  end

  def core_repo_http_link(repo)
    url = repo.html_url
    raw "<a href='#{url}' target='_blank'>#{url}</a>"
  end
end
