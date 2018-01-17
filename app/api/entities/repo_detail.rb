module Entities
  class RepoDetail < Grape::Entity
    expose :type  , documentation: { type: String, desc: "Repo Type" }
    expose :uuid  , documentation: { type: String, desc: "Repo UUID" }
    expose :name  , documentation: { type: String, desc: "Repo Name" }
  end
end
