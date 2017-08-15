module UserCmd
  class Create < ApplicationCommand

    attr_subobjects      :user
    attr_delegate_fields :user

    # delegate :authenticatable_salt, :to => :user
    # delegate :published_contracts,  :to => :user
    # delegate :taken_contracts,      :to => :user
    # delegate :xid,                  :to => :user

    def initialize(args)
      xargs = args.except *%i(password)
      @user = User.find_by(xargs) || User.create(args)
    end

    def event_data
      user.attributes
    end
  end
end
