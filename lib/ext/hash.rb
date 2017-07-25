class Hash
  def multi_merge(*args)
    args.unshift(self)
    args.inject { |acc, ele| acc.merge(ele) }
  end

  def to_unsafe_hash
    self
  end
end