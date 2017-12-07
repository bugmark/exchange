class Hash
  def multi_merge(*args)
    args.unshift(self)
    args.inject { |acc, ele| acc.merge(ele) }
  end

  def to_unsafe_hash
    self
  end

  def without_blanks
    self.select {|_key, val| !(val.nil? || val == "")}
  end
end

class BucketHash
  attr_reader :hash
  def initialize(list)
    keys = list.to_a.map {|x| x.round(2)}.sort.uniq
    @hash = keys.reduce({}) {|acc, val| acc[val] = 0; acc }
  end

  def increment(key, val)
    hash[bucket_for(key)] += val
    self
  end

  def values
    hash.map {|k, v| v}
  end

  private

  def bucket_for(ele)
    keys = hash.keys.sort
    keys.find {|x| x > ele} || keys.last
  end
end