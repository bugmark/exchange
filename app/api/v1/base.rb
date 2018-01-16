require "grape-swagger"

module V1
  class Base < Grape::API

    mount V1::Collections
    mount V1::Config
    mount V1::Users
    mount V1::Repos
    mount V1::Issues
    mount V1::Offers
    mount V1::Contracts
    mount V1::Positions
    mount V1::Events

    helpers do
      def current_user
        @current_user
      end
    end

    content_type   :json, 'application/json'
    default_format :json

    add_swagger_documentation(
        api_version: "v1"       ,
        mount_path:  "/docs"    ,
        base_path:   "/api/v1"  ,
        security_definitions: {
          base: {type: "basic"}
        },
        security:    [{base: []}],
        info: {
          title:        "Bugmark API"                                 ,
          description:  "all calls require BASIC AUTH"                ,
          contact_name: "Andrew Leak - andy@r210.com - 650-823-0836"  ,
        }
      )
  end
end
