module V1
  class Repos < V1::App

    resource :repos do

      # ---------- list all repos ----------
      desc "List all repos", {
        is_array: true ,
        success:  Entities::RepoOverview
      }
      get do
        present(Repo.all, with: Entities::RepoOverview)
      end

      # ---------- show repo detail ----------
      desc "Show repo detail", {
        success: Entities::RepoDetail
      }
      params do
        requires :uuid   , type: String , desc: "repo UUID"
        optional :issues , type: Boolean, desc: "include issues"
      end
      get ':uuid' do
        if repo = Repo.find_by_uuid(params[:uuid])
          opts = {
            with:   Entities::RepoDetail      ,
            issues: params[:issues].to_s
          }
          present(repo, opts)
        else
          error!("not found", 404)
        end
      end

      # ---------- create a repo ----------
      # TODO: return error code for duplicate repo
      # TODO: return error code for non-existant repo
      desc "Create a repo", {
        success:  Entities::RepoOverview   ,
        consumes: ['multipart/form-data']  ,
        detail: <<-EOF.strip_heredoc
          Create a GitHub repo.
        EOF
      }
      params do
        requires :name , type: String , desc: "repo name"
        optional :sync , type: Boolean, desc: "sync on create"
      end
      post do
        opts = { name: params[:name], type: "Repo::GitHub" }
        cmd = RepoCmd::GhCreate.new(opts)
        if cmd.valid?
          cmd.project
          repo = cmd.repo
          RepoCmd::GhSync.from_repo(repo).project if params[:sync]
          present(repo, with: Entities::RepoDetail)
        else
          error!(400, cmd.errors.messages.to_s)
        end
      end

      # ---------- sync a repo ----------
      # TODO: return error code for duplicate repo
      # TODO: return error code for non-existant repo
      desc "Sync a repo", {
        success:  Entities::Status         ,
        consumes: ['multipart/form-data']  ,
        detail: <<-EOF.strip_heredoc
          Sync a GitHub repo.
        EOF
      }
      params do
        requires :uuid , type: String , desc: "repo uuid"
      end
      put do
        opts = { name: params[:name], type: "Repo::GitHub" }
        cmd = RepoCmd::GhCreate.new(opts)
        if repo = Repo.find_by_uuid(params[:uuid])
          RepoCmd::GhSync.from_repo(repo).project
          present(repo, with: Entities::RepoDetail)
        else
          error!(400, cmd.errors.messages.to_s)
        end
      end
    end
  end
end
