require 'erb'

def render(from)
  erb = File.read(__dir__ + "/tasks/templates/#{from}")
  ERB.new(erb).result(binding)
end

def template(from, to)
  tdir = "/tmp/cap_template"
  tfil = "#{tdir}/#{SecureRandom.uuid}"
  system("rm -f #{tdir}") unless Dir.exist?(tdir)
  system("mkdir -p #{tdir}")
  File.open(tfil, 'w') {|f| f.puts render(from)}
  upload! tfil, to
  system("rm -f #{tfil}")
end

