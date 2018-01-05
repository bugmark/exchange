class ApplicationApi < Grape::API
  mount V1::Base    => "/v1"
  mount Vtest::Base => "/vtest"
end
