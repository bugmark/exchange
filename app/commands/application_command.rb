# inspired by
# http://blog.sundaycoding.com/blog/2016/01/08/contextual-validations-with-form-objects

class ApplicationCommand
  include ActiveModel::Model

  # define an attr_accessor for each subobject
  # define a method `subobject_symbols` that returns the list of subobjects
  def self.attr_subobjects(*klas_list)
    attr_accessor(*klas_list)
    define_method 'subobject_symbols' do
      klas_list
    end
  end

  # delegate all fields of a subobject to the subobject
  def self.attr_delegate_fields(*klas_list)
    klas_list.each do |sym|
      klas = sym.to_s.camelize.constantize
      fields1 = klas.attribute_names.map(&:to_sym)
      fields2 = klas.attribute_names.map { |x| "#{x}=".to_sym }
      delegate *fields1, to: sym
      delegate *fields2, to: sym
    end
  end

  def self.from_event(_event)
    raise "from_event: override in subclass"
  end

  # return the list of subobjects
  def subobjects
    subobject_symbols.map { |el| self.send(el) }
  end

  alias_method :subs, :subobjects

  def save
    raise "NOT ALLOWED - USE #project"
  end

  def save_event
    puts "APPEND_EVENT"
  end

  def project
    if valid?
      transact_before_project # perform a transaction, if any
      subs.each(&:save) # save all subobjects
    else
      false
    end
  end

  def valid?
    if super && subs.map(&:valid?).all?
      true
    else
      subs.each do |object|
        object.valid? # populate the subobject errors
        object.errors.each do |field, error| # transfer the error messages
          errors.add(field, error)
        end
      end
      false
    end
  end

  def invalid?
    !valid?
  end

  def event_data

  end

  def transact_before_project
    raise "transact_before_project method: override in subclass"
  end
end
