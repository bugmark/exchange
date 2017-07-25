require_relative './ar_proxy'

module ActiveType
  module Helpers
    def h
      ActionController::Base.helpers
    end
  end
end

