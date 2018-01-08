require "grape-swagger"

module Vtest
  class Base < Grape::API
    mount Vtest::Test
  end
end
