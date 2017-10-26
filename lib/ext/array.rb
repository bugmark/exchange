class Array

  def becomes(klass)
    self.map {|x| x.becomes(klass)}
  end

  # returns an array with all possible combined sums of a list of numbers
  def allsums
    combs = (0..self.length).map {|len| self.combination(len)}
    combs.map {|x| x.map {|y| y}}.flatten(1).map {|x| x.sum}.uniq.sort
  end

  def avg
    self.sum / self.length.to_f
  end

  def avg_time
    Time.at (self.map(&:to_i).sum / self.length).to_i
  end
end
