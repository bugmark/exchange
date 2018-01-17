module V1
  class Repos < V1::App

    helpers do
      def repo_details(repo)
        {
          type:  repo.type  ,
          uuid:  repo.uuid  ,
          name:  repo.name  ,
        }
      end
    end

    resource :repos do
      desc "List all repos",
           is_array: true ,
           http_codes: [
             { code: 200, message: "Repo list", model: Entities::RepoOverview }
           ]
      get do
        Repo.all.map {|repo| {uuid: repo.uuid, name: repo.name}}
      end

      desc "Show repo detail",
           http_codes: [
             { code: 200, message: "Repo detail", model: Entities::RepoDetail }
           ]
      get ':uuid', requirements: { uuid: /.*/ } do
        repo = Repo.find_by_uuid(params[:uuid])
        repo ? issue_details(repo) : error!("Not found", 404)
      end
    end
  end
end
