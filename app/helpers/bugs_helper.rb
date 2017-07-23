module BugsHelper
  def bug_title_link(bug)
    title = truncate(bug.title)
    raw "<a href='/bugs/#{bug.id}'>#{title}</a>"
  end

  def bug_contract_link(bug)
    count = bug.contracts.count
    if count > 0
      raw "<a href='/contracts?bug_id=#{bug.id}'>#{count}</a>"
    else
      count
    end
  end

  def bug_forecast_link(bug)
    path = "contracts/new?type=forecast&bug_id=#{bug.id}"
    raw "<a href='#{path}'>Forecast</a>"
  end

  def bug_reward_link(bug)
    path = "contracts/new?type=reward&bug_id=#{bug.id}"
    raw "<a href='#{path}'>Reward</a>"
  end
end
