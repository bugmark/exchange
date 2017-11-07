class ApplicationApi < Grape::API
  mount V1::Base => "/v1"
  mount Vz::Base => "/vz"
end
