ActiveRecord::Reflection::AssociationReflection.class_eval do
  def set_klass(klass)
    @klass = klass
  end
end

ActiveRecord::Relation.class_eval do
  def set_klass(klass)
    @klass = klass
    @association.reflection.set_klass(klass)
    self
  end
end

ActiveRecord::Base.class_eval do
  class << self
    def becomes(new_klass)
      if Rails.version.match(/^[45]/)
        child_relation(new_klass).merge(all)    # Required for Rails4
      else
        new_klass.scoped.merge(scoped)          # Rails3 syntax from @henning
      end
    end

    private

    def child_relation(new_klass)
      original_value, self.abstract_class = [self.abstract_class, true]
      relation = new_klass.all
      self.abstract_class = original_value
      relation
    end
  end
end

# to test in pry:
# > load 'ext/ar_proxy.rb'; Team.find(4).memberships.becomes(Membership::AsPaging).first.class

ActiveRecord::Base.class_eval do
  def self.change_association(association, new_opts)
    assoc = self.reflect_on_association(association)
    raise "Unrecognized Association: #{association}" if assoc.blank?
    opts  = assoc.options.merge(new_opts)
    self.send(assoc.macro, association, opts)
  end
end