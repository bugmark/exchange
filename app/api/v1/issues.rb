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
        requires :issue_exid , type: String , desc: "issue exid"
      end
      get ':issue_exid' do
        if issue = Issue.find_by_exid(params[:issue_exid])
          present(issue, with: Entities::IssueDetail)
        else
          error!("issue uuid not found", 404)
        end
      end

      # ---------- show issue contracts ----------
      desc "Show issue contracts", {
        is_array: true                         ,
        success:  Entities::ContractDetail     ,
        failure:  [[404, "ISSUE UUID NOT FOUND"]]
      }
      params do
        requires :issue_exid , type: String , desc: "issue exid"
      end
      get ':issue_exid/contracts' do
        if issue = Issue.find_by_exid(params[:issue_exid])
          present(issue.contracts, with: Entities::ContractDetail)
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
        optional :repo_uuid  , type: String , desc: "repo uuid"
        optional :issue_uuid , type: String , desc: "issue uuid"
        optional :title      , type: String , desc: "issue title"
        optional :status     , type: String , desc: "issue status" , values: %w(open closed)
        optional :labels     , type: String , desc: "TBD"
        optional :xfields    , type: String , desc: "TBD"
        optional :jfields    , type: String , desc: "TBD"
      end
      post ':exid' do
        repo_uuid = params[:repo_uuid]
        repo = Repo.find_by_uuid(repo_uuid)
        error!("Repo not found (#{repo_uuid})") if repo_uuid && repo.nil?
        opts = {}
        opts["type"] = repo.type.gsub("Repo", "Issue") if repo
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
