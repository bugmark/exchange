module V1
  class Issues < V1::App

    resource :issues do

      # ---------- list all issues ----------
      desc "List all issues", {
        is_array: true ,
        success: Entities::IssueOverview
      }
      get do
        present Issue.all, with: Entities::IssueOverview
      end

      # ---------- show one issue ----------
      desc "Show issue detail", {
        success: Entities::IssueDetail     ,
        failure: [[404, "ISSUE UUID NOT FOUND"]]
      }
      params do
        requires :issue_uuid , type: String , desc: "issue uuid"
      end
      get ':issue_uuid', requirements: { issue_uuid: /.*/ } do
        if issue = Issue.find_by_uuid(params[:issue_uuid])
          present(issue, with: Entities::IssueDetail)
        else
          error!("issue uuid not found", 404)
        end
      end

    end
  end
end
