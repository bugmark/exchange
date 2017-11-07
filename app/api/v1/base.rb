require "grape-swagger"

module V1
  class Base < Grape::API
    mount V1::Test

    add_swagger_documentation(
        api_version: "v1",
        mount_path: "/docs",
        info: {
          title:         "BugMark API"                ,
          description:   "A restful API for BugMark"  ,
        }
      )
  end
end
