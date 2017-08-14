module UserCmd
  class Create < ApplicationCommand

    attr_subobjects      :user
    attr_delegate_fields :user

    def initialize(args)
      xargs = args.except *%i(password)
      @user = User.find_by(xargs) || User.create(args)
    end

    # def self.from_event(event)
    #   instance = allocate
    #   instance.repo = Repo.find_or_create_by(event.data)
    #   instance
    # end

    def event_data
      user.attributes
    end
  end
end
