class CreateTables < ActiveRecord::Migration[5.1]
  def change

    enable_extension "hstore"

    create_table :repos do |t|
      t.string   :type            # Repo::BugZilla, Repo::GitHub, Repo::Cvrf,
      t.string   :name            # mvscorg/xdmarket
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: '{}'
      t.datetime :synced_at
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :repos, :exref
    add_index :repos, :uuref
    add_index :repos, :type
    add_index :repos, :name
    add_index :repos, :jfields, using: :gin
    add_index :repos, :xfields, using: :gin

    create_table :bugs do |t|
      t.integer  :repo_id
      t.string   :type             # BugZilla, GitHub, Cve
      t.string   :title
      t.string   :description
      t.string   :status
      t.text     :labels,   array: true, default: []
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: '{}'
      t.datetime :synced_at
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :bugs, :exref
    add_index :bugs, :uuref
    add_index :bugs, :repo_id
    add_index :bugs, :type
    add_index :bugs, :labels , using: :gin
    add_index :bugs, :jfields, using: :gin
    add_index :bugs, :xfields, using: :gin

    %i(bids asks).each do |table|
      create_table table do |t|
        t.string   :type                         # BugZilla, GitHub, CVE
        t.integer  :user_id
        t.integer  :contract_id
        t.integer  :volume     , default: 1      # Greater than zero
        t.float    :price      , default: 0.50   # between 0.00 and 1.00
        t.boolean  :all_or_none, default: false
        t.string   :status                       # open, closed
        t.datetime :offer_expiration
        t.datetime :contract_maturation
        # ----- match fields -----
        t.integer  :repo_id
        t.integer  :bug_id
        t.string   :bug_title
        t.string   :bug_status
        t.string   :bug_labels
        # ----- match fields -----
        t.jsonb    :jfields,  null: false, default: '{}'
        t.string   :exref
        t.string   :uuref
      end
      add_index table, :type
      add_index table, :user_id
      add_index table, :contract_id
      add_index table, :exref
      add_index table, :uuref
      add_index table, :repo_id
      add_index table, :bug_id
      add_index table, :jfields, using: :gin
    end

    create_table :contracts do |t|
      t.string   :type                # GitHub, BugZilla, ...
      t.string   :mode                # reward, forecast
      t.string   :status              # open, matured, resolved
      t.string   :awarded_to          # bidder, asker
      t.datetime :contract_maturation
      t.integer  :volume
      t.float    :price
      # ----- match fields
      t.integer  :repo_id
      t.integer  :bug_id
      t.string   :bug_title
      t.string   :bug_status
      t.string   :bug_labels
      # -----
      t.jsonb    :jfields,  null: false, default: '{}'
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :contracts, :exref
    add_index :contracts, :uuref
    add_index :contracts, :repo_id
    add_index :contracts, :bug_id
    add_index :contracts, :jfields, using: :gin

    create_table :users do |t|
      t.boolean  :admin
      t.integer  :token_balance
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :users, :exref
    add_index :users, :uuref

    # the event store...
    create_table :event_lines do |t|
      t.string     :klas
      t.string     :uuref
      t.string     :local_hash
      t.string     :chain_hash
      t.jsonb      :data,  null: false, default: '{}'
      t.timestamps
    end
    add_index :event_lines, :klas
    add_index :event_lines, :local_hash
    add_index :event_lines, :chain_hash
    add_index :event_lines, :uuref
    add_index :event_lines, :data      , using: :gin

    # holds an event counter for a projection
    create_table :projections do |t|
      t.string  :name
      t.integer :event_counter
    end
  end
end
