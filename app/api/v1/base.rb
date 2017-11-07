require "grape-swagger"

module V1
  class Base < Grape::API
    # mount V1::Sessions
    mount V1::Test

    # add_swagger_documentation(
    #     api_version: "v1",
    #     hide_documentation_path: true,
    #     mount_path: "/api/v1/api_doc",
    #     hide_format: true
    #   )
  end
end
