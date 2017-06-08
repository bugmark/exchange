#!/usr/bin/env ruby

require 'logger'

$stdin.sync = true
$stdout.sync = true

# logpath = "/tmp/eee.log"
# logfile = File.open(logpath, File::WRONLY | File::APPEND | File::CREAT)
# logfile.sync = true
# log = Logger.new(logfile)
# log.level = Logger::DEBUG

def auth(username, password)
  return true
end

msg = 'Starting ejabberd auth service'
# log.info msg
puts msg

loop do
  begin
    # log.info "Waiting for input..."
    $stdin.eof?
    start = Time.now

    msg1 = $stdin.read(2)
    leng = msg1.unpack('n').first

    msg2 = $stdin.read(leng)
    cmd, *data = msg.split(':')
    user, pass = [data[0], data[1]]

    # log.info "Incoming Request: '#{cmd}'"
    success = case cmd
              when 'auth'
                # log.info "Authenticating #{user}@#{pass}"
                auth user, pass
              else
                false
              end

    bool = success ? 1 : 0
    $stdout.write [2, bool].pack('nn')
    # log.info "Response: #{bool}"
  rescue => e
    puts 'Exception...'.yellow
    # log.error #{e.class.name}: #{e.message}"
    # log.error e.backtrace.join("\\\\\\\\n\\\\\\\\t")
  end
end

