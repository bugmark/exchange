require "grape-swagger"

module V1
  class Base < Grape::API
    mount V1::Collections

    helpers do
      def current_user
        @current_user
      end
    end

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
