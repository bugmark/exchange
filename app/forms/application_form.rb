class ApplicationForm
  include ActiveModel::Model

  def self.attr_subobjects(*list)
    attr_accessor(*list)
    define_method 'subobject_symbols' do
      list
    end
  end

  # def initialize(args={})
  #   args.each do |k,v|
  #     key = "@#{k}"
  #     instance_variable_set(key.to_sym, v) unless v.nil?
  #   end
  # end

  def save
    valid? ? subs.each(&:save) : false
  end

  def valid?
    if super && subs.map(&:valid?).all?
      true
    else
      subs.each do |object|
        object.valid?
        object.errors.each do |field, error|
          errors.add(field, error)
        end
      end
      false
    end
  end

  def subobjects
    subobject_symbols.map {|el| self.send(el)}
  end
  alias_method :subs, :subobjects

  def invalid?
    ! valid?
  end
end
