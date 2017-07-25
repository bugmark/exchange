class ApplicationForm
  include ActiveModel::Model

  def initialize(args={})
    args.each do |k,v|
      key = "@#{k}"
      instance_variable_set(key.to_sym, v) unless v.nil?
    end
  end
end
