module ReposHelper
  def repo_forecast_link(repo)
    path = "contracts/new?type=forecast?repo_id=#{repo.id}"
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
