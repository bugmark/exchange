module BugCmd
  class Sync < ApplicationCommand

    attr_subobjects      :bug
    attr_delegate_fields :bug

    def initialize(args)
      @bug = Bug.find_or_create_by(exid: args["exid"])
      @bug.assign_attributes(args)
    end

  end
end