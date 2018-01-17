module Entities
  class RepoOverview < Grape::Entity
    expose :uuid  , documentation: { type: String, desc: "Repo UUID" }
    expose :name  , documentation: { type: String, desc: "Repo Name" }
  end
end
