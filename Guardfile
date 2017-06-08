# vim: set ft=ruby:

require 'colored'

notification :off   # rspec uses sound notification...

scope groups: [:rs]

# ----- load Rails -------------------------------------------------------------

unless defined?(RAILS)
  ENV['RAILS_ROOT'] = File.expand_path('../../', __FILE__)
  require File.expand_path('../config/environment', __FILE__)
  require 'rails/console/app'
  require 'rails/console/helpers'
  puts 'Loaded Rails Environment'
end

ignore %w(bin data vendor config db log public).map {|x| Regexp.new("^#{x}/*")}

# ----- RSPEC_MIN COMMANDS -----------------------------------------------------

require 'guard/rspec_min_util/commands'
RS_COMMANDS = ::Guard::RspecMinUtil::Commands
Pry::Commands.import RS_COMMANDS.command_set

# ----- RSPEC_MIN PATTERNS -----------------------------------------------------

def expand_targets(share_file, pattern)
  tgts = []
  File.open(share_file).each do |line|
    if Regexp.new("#{pattern}(.*)").match(line)
      tgts += $1.split
    end
  end
  tgts.map {|tgt| "spec/#{tgt}_spec.rb"}.sort.uniq
end

def consumers_for(share_file)
  expand_targets(share_file, '# *required_by *:')
end

def integration_tests_for(subject_file)
  expand_targets(subject_file, '# *integration_tests? *:')
end

spec_regex         = %r{^spec/.+_spec\.rb$}
shared_regex       = %r{^spec/(.+)_shared?\.rb$}
view_regex         = %r{^app/(.*)\.(erb|slim)$}
view_stack_regex   = %r{^app/views/(.+)/(.+)\.html\.(erb|slim)$}
controller_regex   = %r{^app/controllers/(.+)_(controller)\.rb$}
app_controller     = 'app/controllers/application_controller.rb'

group :rs do
  guard :rspec_min do
    watch(app_controller)        { 'spec/controllers' }
    watch(%r{^lib/(.+)\.rb$})    { |m| "spec/lib/#{m[1]}_spec.rb"              }
    watch(%r{^script/(.+)\.rb$}) { |m| "spec/script/#{m[1]}_spec.rb"           }
    watch(%r{^app/(.+)\.rb$})    { |m| "spec/#{m[1]}_spec.rb"                  }
    watch(controller_regex)      { |m| "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb" }
    watch(view_regex)            { |m| "spec/#{m[1]}.#{m[2]}_spec.rb"          }
    watch(view_stack_regex)      { |m| "spec/features/#{m[1]}_#{m[2]}_spec.rb" }
    watch(view_stack_regex)      { |m| "spec/requests/#{m[1]}_#{m[2]}_spec.rb" }
    watch(controller_regex)      { |m| integration_tests_for(m[0])             }
    watch(view_regex)            { |m| integration_tests_for(m[0])             }
    watch(%r{^app/(.+)\.rb$})    { |m| integration_tests_for(m[0])             }
    watch(%r{^lib/(.+)\.rb$})    { |m| integration_tests_for(m[0])             }
    watch(%r{^app/(.+)\.rb$})    { |m| consumers_for(m[0])                     }
    watch(shared_regex)          { |m| consumers_for(m[0])                     }
    watch(spec_regex)            { |m| consumers_for(m[0])                     }
    watch(spec_regex)            { |m| integration_tests_for(m[0])             }
    watch(spec_regex)

    callback(:run_all_end)              { RS_COMMANDS.prompt }
    callback(:run_on_modifications_end) { RS_COMMANDS.prompt }
  end
end

# ----- PRYRC SETUP ------------------------------------------------------------

pryrc = File.expand_path('~/.pryrc')
load pryrc if File.exist?(pryrc)


