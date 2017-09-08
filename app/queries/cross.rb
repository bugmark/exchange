class Cross
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def generate
    {asks: cross_asks, bids: cross_bids}
  end

  private

  def cross_asks
    cross_using(Ask.base_scope)
  end

  def cross_bids
    cross_using(Bid.base_scope)
  end

  def cross_using(base_scope)
    params.without_blanks.reduce(base_scope) do |acc, (key, val)|
      scope_for(acc, key, val)
    end
  end

  def scope_for(base, key, val)
    case key
      when :id then
        base.by_id(val)
      when :repo_id then
        base.by_repoid(val)
      when :title then
        base.by_title(val)
      when :status then
        base.by_status(val)
      when :labels then
        base.by_labels(val)
      else base
    end
  end

end