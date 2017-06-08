#!/usr/bin/env ruby
#
# derived from
# http://pivotallabs.com/swapping-javascript-spec-implementation-rubymine/

require_relative "./rubymine_finder"


MINE = "/home/aleak/lcl/bin/rubymine/bin/rubymine.sh"

abort "ERROR: Missing Target File" if ARGV.length == 0

tgt_path = RubymineFinder.new(ARGV[0]).tgt_path

File.open("/tmp/output.txt", 'w') {|f| f.puts ARGV[0], tgt_path}

system "touch #{tgt_path}"
system "nohup #{MINE} #{tgt_path} > /dev/null 2>&1 &"