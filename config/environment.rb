# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

puts "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
puts $0
puts "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"

if $0 == "rails_console"
  puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
end
