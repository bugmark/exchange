module DatapointCmd
  class Base < ApplicationCommand
    def initialize
      add_event :proxy, Event::DpBaseLogged.new(cmd_opts)
    end
  end
end
