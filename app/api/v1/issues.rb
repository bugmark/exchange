module V1
  class Issues < V1::App

    helpers do
      def issue_details(repo)
        {
          type:  repo.type  ,
          uuid:  repo.uuid
        }
      end
    end

    resource :issues do
      desc "List all issues",
           is_array: true ,
           http_codes: [
             { code: 200, message: "Issue list", model: Entities::IssueOverview }
           ]
      get do
        Issue.all.map {|issue| {uuid: issue.uuid}}
      end

      desc "Show issue detail",
           http_codes: [
             { code: 200, message: "Issue detail", model: Entities::IssueDetail }
           ]
      get ':uuid', requirements: { uuid: /.*/ } do
        issue = Issue.find_by_uuid(params[:uuid])
        issue ? issue_details(issue) : error!("Not found", 404)
      end
    end
  end
end
