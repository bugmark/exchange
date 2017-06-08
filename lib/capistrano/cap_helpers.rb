require 'erb'

def render(from)
  erb = File.read(__dir__ + "/tasks/templates/#{from}")
  ERB.new(erb).result(binding)
end

def template(from, to)
  tmpfile = '/tmp/cap_template'
  File.open(tmpfile, 'w') {|f| f.puts render(from)}
  upload! tmpfile, to
end

