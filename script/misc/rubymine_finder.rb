# derived from
# http://pivotallabs.com/swapping-javascript-spec-implementation-rubymine/

class RubymineFinder
  attr_accessor :src_path

  def initialize(src_path = nil)
    File.open("/tmp/outnew.txt", 'w') {|f| f.puts "YO", src_path, Time.now}
    @src_path = src_path
  end

  def tgt_path
    return nil if src_path.nil?
    related_file
  end

  private

  def related_file
    src_is_spec? ? spec_to_impl : impl_to_spec
  end

  def spec_to_impl
    src_path.gsub(opts.spec, opts.impl).gsub('_spec', '')
  end

  def impl_to_spec
    base, ext = src_path.gsub(opts.impl, opts.spec).split('.', 2)
    [base, '_spec.', ext].join
  end

  Opts = Struct.new(:type, :impl, :spec)

  def opts
    @opts ||= begin
      args = case filetype
             when :coffee then %w(app/assets/ spec/     )
             when :libs    then %w(lib/        spec/lib/ )
             else              %w(app/        spec/     )
             end
      Opts.new(filetype, *args)
    end
  end

  def filetype
    @type ||= case src_path.to_s
    when /coffee/   then :coffee
    when /lib/      then :libs
    else :other
    end
  end

  def src_is_spec?
    src_path.match /_spec/
  end
end
