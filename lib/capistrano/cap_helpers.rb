require 'erb'

def render(from, locals)
  erb = File.read(__dir__ + "/tasks/templates/#{from}")
  lcl = binding.clone
  locals.each { |k,v| lcl.local_variable_set(k, v) }
  ERB.new(erb).result(lcl)
end

def template(from, to, locals = {})
  tdir = "/tmp/cap_template"
  tfil = "#{tdir}/#{SecureRandom.uuid}"
  system("rm -f #{tdir}") unless Dir.exist?(tdir)
  system("mkdir -p #{tdir}")
  File.open(tfil, 'w') {|f| f.puts render(from, locals)}
  upload! tfil, to
  # system("rm -f #{tfil}")
end
