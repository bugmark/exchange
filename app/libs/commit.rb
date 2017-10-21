module Commit
  def self.init(type, bundle)
    klas = case type
      when :expand  then Commit::Expand
      when :realloc then Commit::Realloc
      when :reduce  then Commit::Reduce
      else rase "Unrecognized type #{type}"
    end
    klas.new(type, bundle)
  end
end