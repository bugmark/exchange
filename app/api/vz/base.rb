require "grape-swagger"

module Vz
  class Base < Grape::API
    mount Vz::Test
  end
end
