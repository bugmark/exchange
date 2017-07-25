class Array

  def becomes(klass)
    self.map {|x| x.becomes(klass)}
  end

end
