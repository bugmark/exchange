class Time

  DATE_REGEX = /\A20[01][0-9]\-[01][0-9]\-[0123][0-9]\Z/
  TIME_REGEX = /\A[012][0-9]\:[0-5][0-9]\Z/

  def date_part
    strftime('%Y-%m-%d')
  end
  alias_method :qdate, :date_part

  def time_part
    strftime('%H:%M')
  end
  alias_method :time, :time_part

  def iso8601
    strftime('%Y-%m-%dT%H:%M:%S.%L%z')
  end

  def fmt
    "#{date_part} #{time_part}"
  end

  def change_date=(string)
    raise 'requires a string' unless string.is_a?(String)
    raise 'invalid format'    unless string.match? DATE_REGEX
    Time.new "#{string} #{time_part}"
  end

  def change_time=(string)
    raise 'requires a string' unless string.is_a?(String)
    raise 'invalid format'    unless string.match? TIME_REGEX
    Time.new "#{date_part} string"
  end

end
