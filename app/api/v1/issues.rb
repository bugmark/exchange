module V1
  class Issues < V1::App

    resource :issues do

      # ---------- list all issues ----------
      desc "List all issues", {
        is_array: true ,
        success: Entities::IssueOverview
      }
      params do
        optional :limit , type: Integer , desc: "count limit"
      end
      get do
        list = Issue.all.limit(params[:limit] || 999)
        present list, with: Entities::IssueOverview
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

      # ---------- sync an issue ----------
      desc "Sync", {
        success:  Entities::IssueDetail            ,
        failure:  [[404, "ISSUE EXID NOT FOUND"]]  ,
        consumes: ['multipart/form-data']
      }
      params do
        requires :exid       , type: String , desc: "issue exid"
        optional :type       , type: String , desc: "issue type", values: %w(Test GitHub)
        optional :repo_uuid  , type: String , desc: "repo uuid"
        optional :issue_uuid , type: String , desc: "issue uuid"
        optional :title      , type: String , desc: "TBD"
        optional :status     , type: String , desc: "TBD"
        optional :labels     , type: String , desc: "TBD"
        optional :xfields    , type: String , desc: "TBD"
        optional :jfields    , type: String , desc: "TBD"
      end
      post ':exid' do
        opts = {}
        opts["type"] = "Issue::" + params[:type] if params[:type]
        opts["exid"] = params[:exid]
        %w(repo_uuid issue_uuid title status labels).each do |el|
          opts["stm_" + el] = params[el.to_sym] if params[el.to_sym]
        end
        %w(xfields jfields).each do |el|
          opts["stm_" + el] = JSON.parse(params[el.to_sym]) if params[el.to_sym]
        end
        cmd = IssueCmd::Sync.new(opts)
        if cmd.valid?
          issue = cmd.project.issue
          present(issue, with: Entities::IssueDetail)
        else
          error!(cmd.errors.messages.join(", "), 404)
        end
      end
    end
  end
end
