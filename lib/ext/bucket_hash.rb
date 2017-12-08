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