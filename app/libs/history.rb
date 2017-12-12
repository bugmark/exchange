class History

  attr_accessor :path, :user

  def initialize(path, user)
    @path = path
    @user = user
  end

  def period(int)
    get_lcl_hash.fetch(int.to_s, {})
  end

  def update
    get_lcl_hash
    (0..3).each do |period|
      newdate = {"date" => date_for(period)}
      @lcl_hash[period.to_s] = @lcl_hash.fetch(period.to_s, {}).merge(newdate)
    end
    @lcl_hash[current_period.to_s] = {
      "date"               => date_for(current_period),
      "closed_issues"      => Bug.closed.count,
      "resolved_contracts" => Contract.resolved.count,
      "balance"            => user.balance
    }
    File.open(path, "w") {|f| f.puts @lcl_hash.to_json}
  end

  private

  def current_period
    BugmTime.day_offset / 8
  end

  def date_for(period)
    base = BugmTime.now - (current_period * 8).days
    (base + (period * 8).days).strftime("%b %d")
  end

  def current_day
    BugmTime.now.strftime("%b %d")
  end

  def get_lcl_hash
    @lcl_json ||= File.exist?(path) ? File.read(path) : "{}"
    @lcl_hash ||= JSON.parse @lcl_json
  end

end