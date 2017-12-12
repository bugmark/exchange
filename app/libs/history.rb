class History
  attr_reader :path
  def initialize(path)
    @path = path

  end

  def period(int)
    lcl_hash.fetch(int, {})
  end

  def update

  end

  private

  def lcl_hash
    @lcl_json ||= File.exist?(path) ? File.read(path) : "{}"
    @lcl_hash ||= JSON.parse @lcl_json
  end

end