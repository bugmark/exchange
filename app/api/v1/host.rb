module V1
  class Host < V1::App

    resource :host do

      # ---------- show host info ----------
      desc "get host info", {
        success: Entities::HostInfo                ,
        detail: <<-EOF.strip_heredoc
          Show host info: host-time, day offset, datastore type, etc.
        EOF
      }
      get "/info" do
        fn   = "/tmp/bugm_build_date.txt"
        data = {
          host_name:   BugmHost.name,
          host_time:   BugmTime.now.to_s,
          day_offset:  BugmTime.day_offset,
          usermail:    current_user&.email,
          datastore:   BugmHost.datastore,
          released_at: File.exist?(fn) ? File.read(fn).strip : "NA"
        }
        present(data, with: Entities::HostInfo)
      end

      # ---------- ping: get heartbeat ----------
      desc "check server access", {
        success: Entities::Status
      }
      get "/ping" do
        {status: "OK"}
      end

      # ---------- list host counts ----------
      desc "counts", {
        success: Entities::HostCount                   ,
        detail: <<-EOF.strip_heredoc
          Show host object counts: number of users, offers, contracts, etc.
        EOF
      }
      get "/counts" do
        {
          host_name:  BugmHost.name             ,
          host_time:  BugmTime.now.to_s         ,
          num_users:  User.count                ,
          num_repos:  Repo.count                ,
          num_issues: Issue.count               ,
          bu_offers:  Offer::Buy::Unfixed.count ,
          bf_offers:  Offer::Buy::Fixed.count   ,
          contracts:  Contract.count            ,
          positions:  Position.count            ,
          escrows:    Escrow.count              ,
          amendments: Amendment.count           ,
          events:     Event.count
        }
      end

      # ---------- next week-ends ----------
      desc "next week-ends", {
        success:  Entities::NextWeekEnds
      }
      params do
        optional :count, type: Integer, desc: "count (default 4)"
      end
      get "/next_week_ends" do
        list = BugmTime.next_week_ends(params[:count] || 4)
        present({next_week_ends: list}, with: Entities::NextWeekEnds)
      end

      # ---------- increment day offset ----------
      desc "increment day offset", {
        success:  Entities::Status     ,
        consumes: ['multipart/form-data']
      }
      params do
        optional :count, type: Integer, desc: "count (default 1)"
      end
      put "/increment_day_offset" do
        BugmTime.increment_day_offset(params[:count] || 1)
        {status: "OK"}
      end

      # ---------- rebuild the system----------
      desc "rebuild", {
        success:  Entities::Status                               ,
        failure:  [[403, "Can't Rebuild Permanent Datastore"]]   ,
        consumes: ['multipart/form-data']                        ,
        detail: <<~EOF
          Destroy all data and rebuild the system. The rebuilt system 
          will have one user: `user/pass` = `admin@bugmark.net/bugmark`.

          To run this command, you must post a confirmation parameter:
          `/host/rebuild?confirm=destroy_all_data`

          The rebuild command is intended for use on hosts dedicated for 
          research and testing. (and not production!)  The rebuild command will
          work for hosts with `mutable` datastores, and will fail for hosts
          with `permanent` datastores.

          View the datastore setting with the `/hosts/info` command.
        EOF
      }
      params do
        requires :affirm, type: String, desc: "confirmation", values: ["destroy_all_data"]
      end
      post "/rebuild" do
        error!("Permanent Datastore", 403) if BugmHost.datastore != 'mutable'
        list = %w(Repo User Offer Escrow Position Amendment Contract Event)
        list.each {|el| Object.const_get(el).destroy_all}
        BugmTime.clear_day_offset
        UserCmd::Create.new({email: 'admin@bugmark.net', password: 'bugmark'}).project
        {status: "OK", message: "all data destroyed - login with admin@bugmark.net"}
      end
    end
  end
end
