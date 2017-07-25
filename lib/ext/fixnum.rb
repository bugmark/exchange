module FormatNums
  def prc
    self.to_s.reverse().split(//).inject() {|x,i| (x.gsub(/ /,'').length % 3 == 0 ) ? x + ',' + i : x + i}.reverse()
  end

  def id
    self
  end
end

# class Fixnum
class Integer
  include FormatNums
end
