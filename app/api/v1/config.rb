module V1
  class Config < V1::App

    resource :ping do
      desc "Check server access",
           is_array: false   ,
           http_codes: [
             { code: 200, message: "Server status", model: Entities::Status}
           ]
      get do
        {status: "OK"}
      end
    end
  end
end
