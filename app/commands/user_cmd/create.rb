module UserCmd
  class Create < ApplicationCommand

    attr_subobjects      :user
    attr_delegate_fields :user

    methods = %i(password password= password_confirmation=)
    delegate *methods, :to => :user


    def initialize(args = {})
      @user = User.find_or_create_by(args)
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
