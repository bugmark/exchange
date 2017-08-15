module BugCmd
  class Sync < ApplicationCommand

    attr_subobjects      :bug
    attr_delegate_fields :bug

    def initialize(args)
      @bug = Bug.find_or_create_by(exref: args["exref"])
      @bug.assign_attributes(args)
    end

    def event_data
      bug.attributes
    end
  end
end
