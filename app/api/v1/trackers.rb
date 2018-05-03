module V1
  class Trackers < V1::App

    resource :trackers do

      # ---------- list all tracker ids ----------
      desc "List all tracker ids", {
        is_array: true ,
        success:  Entities::TrackerIds
      }
      get do
        present(Tracker.all, with: Entities::TrackerIds)
      end

      # ---------- list all tracker details ----------
      desc "List all tracker details", {
        is_array: true ,
        success:  Entities::TrackerDetail
      }
      get '/detail' do
        present(Tracker.all, with: Entities::TrackerDetail)
      end

      # ---------- show tracker detail ----------
      desc "Show detail for one tracker", {
        success: Entities::TrackerDetail
      }
      params do
        requires :uuid   , type: String , desc: "tracker UUID"
        optional :issues , type: Boolean, desc: "include issues"
      end
      get ':uuid' do
        if tracker = Tracker.find_by_uuid(params[:uuid])
          opts = {
            with:   Entities::TrackerDetail      ,
            issues: params[:issues].to_s
          }
          present(tracker, opts)
        else
          error!("not found", 404)
        end
      end

      # ---------- create a tracker ----------
      # TODO: return error code for duplicate tracker
      # TODO: return error code for non-existant tracker
      desc "Create a tracker", {
        success:  Entities::TrackerIds        ,
        consumes: ['multipart/form-data']  ,
        detail: <<-EOF.strip_heredoc
          Create a GitHub tracker.
        EOF
      }
      params do
        requires :type   , type: String , desc: "tracker type", values: %w(GitHub Test)
        requires :name   , type: String , desc: "tracker name"
        optional :ghsync , type: Boolean, desc: "GH sync on create"
      end
      post do
        type, name, ghsync = [params[:type], params[:name], params[:ghsync]]
        opts = { name: name, type: "Tracker::#{type}" }
        cmd = TrackerCmd::Create.new(opts)
        if rep1 = Tracker.find_by_name(name)
          present(rep1, with: Entities::TrackerDetail)
        else
          if cmd.valid?
            cmd.project
            rep2 = cmd.tracker
            TrackerCmd::GhSync.from_tracker(rep2).project if ghsync && type == "GitHub"
            present(rep2, with: Entities::TrackerDetail)
          else
            error!(400, cmd.errors.messages.to_s)
          end
        end
      end

      # ---------- sync a tracker ----------
      # TODO: return error code for duplicate tracker
      # TODO: return error code for non-existant tracker
      desc "Sync a tracker", {
        success:  Entities::Status         ,
        consumes: ['multipart/form-data']  ,
        detail: <<-EOF.strip_heredoc
          Sync a GitHub tracker.
        EOF
      }
      params do
        requires :uuid , type: String , desc: "tracker uuid"
      end
      put do
        opts = { name: params[:name], type: "Tracker::GitHub" }
        cmd = TrackerCmd::GhCreate.new(opts)
        if tracker = Tracker.find_by_uuid(params[:uuid])
          TrackerCmd::GhSync.from_tracker(tracker).project
          present(tracker, with: Entities::TrackerDetail)
        else
          error!(400, cmd.errors.messages.to_s)
        end
      end
    end
  end
end
