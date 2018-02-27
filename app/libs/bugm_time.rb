class BugmTime < Time

  DAY_JUMP_FILE  = "/tmp/bugm_day_jump"
  HOUR_JUMP_FILE = "/tmp/bugm_hour_jump"

  class << self
    def now
      super + day_offset.days + hour_offset.hours
    end

    def now_epoch
      now.to_i
    end

    def day_offset
      return 0 unless File.exist?(DAY_JUMP_FILE)
      File.read(DAY_JUMP_FILE).to_i
    end

    def hour_offset
      return 0 unless File.exist?(HOUR_JUMP_FILE)
      File.read(HOUR_JUMP_FILE).to_i
    end

    def total_hour_offset
      day_offset * 24 + hour_offset
    end

    def offset_eval(string)
      new_str = string.gsub('_', '(') + ")"
      eval(new_string)
    end

    # -------------------------------------------------------

    def released_at
      fn   = "/tmp/bugm_build_date.txt"
      File.exist?(fn) ? File.read(fn).strip : "NA"
    end

    # -------------------------------------------------------

    def set_day_offset(number)
      File.open(DAY_JUMP_FILE, 'w') {|f| f.puts number}
    end

    def increment_day_offset(number)
      return if number < 1
      new_val = day_offset + number
      File.open(DAY_JUMP_FILE, 'w') {|f| f.puts new_val}
    end

    def increment_hour_offset(number)
      return if number < 1
      new_offset  = hour_offset + number
      days, hours = [new_offset / 24, new_offset % 24]
      increment_day_offset(days) if days > 0
      File.open(HOUR_JUMP_FILE, 'w') {|f| f.puts hours}
    end

    # -------------------------------------------------------

    def clear_offset
      clear_day_offset
      clear_hour_offset
    end

    def clear_day_offset
      system "rm -f #{DAY_JUMP_FILE}"
    end

    def clear_hour_offset
      system "rm -f #{HOUR_JUMP_FILE}"
    end

    # -------------------------------------------------------

    def next_week_ends(count = 4)
      eow = now.end_of_week
      (0..count-1).map {|idx| eow + idx.weeks}
    end

    def next_week_dates(count = 4)
      next_week_ends(count).map {|x| x.strftime("%Y-%m-%d")}
    end

    private

    def minutes(count = 1)
      now + count.minutes
    end

    def hours(count = 1)
      now + count.hours
    end

    def days(count = 1)
      now + count.days
    end

    def weeks(count = 1)
      now + count.weeks
    end

    def months(count = 1)
      now + count.months
    end

    def end_of_today
      end_of_day
    end

    def end_of_tomorrow
      end_of_day(1)
    end

    def end_of_hour(count = 0)
      now + count.hours
    end

    def end_of_day(count = 0)
      now.end_of_day + count.days
    end

    def end_of_week(count = 0)
      now.end_of_week + count.weeks
    end

    def end_of_month(count = 0)
      now.end_of_month + count.months
    end
  end
end