require "grape-swagger"

module V1
  class Base < Grape::API
    mount V1::Collections

    http_basic do |email, password|
      @current_user = User.find_by_email(email)
      @current_user && @current_user.valid_password?(password)
    end

    helpers do
      def current_user
        @current_user
      end
    end

    desc "bing bing"

    # content_type :xml,  'application/xml'
    # content_type :json, 'application/json'
    # content_type :yaml, 'text/plain'
    # content_type :txt,  'text/plain'
    # default_format :json

    add_swagger_documentation(
        api_version:   "v1"       ,
        mount_path:    "/docs"    ,
        base_path:     "/api/v1"  ,
        info: {
          title:        "BugMark API"                                 ,
          description:  "all calls require BASIC AUTH"                ,
          contact_name: "Andrew Leak - andy@r210.com - 650-823-0836"  ,
        }
      )
  end
end
