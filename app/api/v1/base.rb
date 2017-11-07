require "grape-swagger"

module V1
  class Base < Grape::API
    mount V1::Collections

    add_swagger_documentation(
        api_version:   "v1"       ,
        mount_path:    "/docs"    ,
        base_path:     "/api/v1"  ,
        info: {
          title:         "BugMark API"                ,
          description:   "A restful API for BugMark"  ,
        }
      )
  end
end
