class BugmTime < Time

  DAY_JUMP_FILE = "/tmp/bugm_day_jump"

  class << self
    def now
      super + day_offset.days
    end

    def increment_day_jump(number)
      new_val = day_offset + number
      File.open(DAY_JUMP_FILE, 'w') {|f| f.puts new_val}
    end

    def clear_day_jump
      system "rm -f #{DAY_JUMP_FILE}"
    end

    def day_offset
      return 0 unless File.exist?(DAY_JUMP_FILE)
      File.read(DAY_JUMP_FILE).to_i
    end

    def future_week_ends(count = 4)
      eow = now.end_of_week
      (0..count-1).map {|idx| eow + idx.weeks}
    end

    def future_week_dates(count = 4)
      future_week_ends(count).map {|x| x.strftime("%y-%m-%d")}
    end
  end
end