# Application Command
#
# - use for forms - edit and create commands - anything that updates the DB
#   - single-model updates
#   - multi-model transactions
# - creates event store
#   - events are the ultimate base of truth
#   - events are signed in a merkle chain
#   - events can come from Rails controllers OR Solidity contracts
#   - most every command emits events
#   - events can have one or more projections
#   - events can be replayed

# - using commands from controllers
#    `Command.new(params).save_event.project`
# - using commands to replay events
#    `Command.from_event(event).project`

# form handling inspired by
# http://blog.sundaycoding.com/blog/2016/01/08/contextual-validations-with-form-objects

class ApplicationCommand
  include ActiveModel::Model

  # ----- configuration methods

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

  # ----- template methods - override in subclass

  def self.from_event(_event)
    raise "from_event: override in subclass"
  end

  def event_data
    raise "event_data: override in subclass"
  end

  def transact_before_project
    raise "transact_before_project method: override in subclass"
  end

  # ----- utility methods

  # return the list of subobjects
  def subobjects
    subobject_symbols.map { |el| self.send(el) }
  end

  alias_method :subs, :subobjects

  def save
    raise "NOT ALLOWED - USE #save_event"
  end

  # append to the event store (the EventLine table...)
  def save_event
    EventLine.new(self.event_data).save
    self
  end

  # pro-jekt - create a projection - an aggregate data view
  def project
    if valid?
      transact_before_project # perform a transaction, if any
      subs.each(&:save)       # save all subobjects
    else
      false
    end
  end

  # uses Rails-style validation
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

end
