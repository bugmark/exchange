module ReposHelper
  def repo_name_link(repo)
    name = truncate(repo.name)
    raw "<a href='/repos/#{repo.id}'>#{name}</a>"
  end

  def repo_forecast_link(repo)
    path = "contracts/new?type=forecast&repo_id=#{repo.id}"
    raw "<a href='#{path}'>Forecast</a>"
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
