class Date

  MONTH_REGEX = /\A20[01][0-9]\-[01][0-9]\Z/
  DATE_REGEX  = /\A20[01][0-9]\-[01][0-9]\-[0123][0-9]\Z/

  def self.month_parse(string)
    if string.match(MONTH_REGEX)
      self.parse "#{string}-01"
    else
      self.parse string
    end
  end

end
