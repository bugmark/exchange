class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :repos do |t|
      t.string   :type            # Repo::BugZilla, Repo::GitHub, Repo::Cvrf,
      t.string   :name            # mvscorg/xdmarket
      t.string   :url
      t.jsonb    :jfields,  null: false, default: '{}'
      t.datetime :synced_at
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :repos, :exref
    add_index :repos, :uuref
    add_index :repos, :type
    add_index :repos, :jfields, using: :gin

    create_table :bugs do |t|
      t.integer  :repo_id
      t.string   :type             # Bug::BugZilla, Bug::GitHub, Bug::Cvrf
      t.string   :api_url
      t.string   :http_url
      t.string   :title
      t.string   :description
      t.string   :status
      t.text     :labels, array: true, default: []
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

    create_table :contracts do |t|
      t.string   :type                # forecast, reward
      t.integer  :publisher_id
      t.integer  :counterparty_id
      t.string   :currency_type
      t.float    :currency_amount
      t.string   :terms               # eg Net0, Net30
      t.string   :status              # open, taken, resolved
      t.string   :awarded_to          # publisher, counterparty
      t.datetime :expires_at
      # ----- match fields
      t.integer  :repo_id
      t.integer  :bug_id
      t.string   :bug_title
      t.string   :bug_status
      t.string   :bug_labels
      t.boolean  :bug_presence
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
    add_index :contracts, :publisher_id
    add_index :contracts, :counterparty_id
    add_index :contracts, :jfields, using: :gin

    create_table :users do |t|
      t.boolean  :admin
      t.integer  :pokerbux_balance
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :users, :exref
    add_index :users, :uuref
  end
end
