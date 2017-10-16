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

    create_table :offers do |t|
      t.string    :type                      # BuyBid, SellBid, BuyAsl, SellAsk
      t.string    :repo_type                 # BugZilla, GitHub, CVE
      t.integer   :user_id                   # the party who made the offer
      t.integer   :parent_id                 # for ReOffers - an Offer
      t.integer   :position_id               # for SaleOffers - a Position
      t.integer   :counter_id                # the counterparty - an Offer
      t.integer   :volume, default: 1        # Greater than zero
      t.float     :price , default: 0.50     # between 0.00 and 1.00
      t.boolean   :poolable, default: true   # for reserve pooling
      t.boolean   :aon     , default: false  # All Or None
      t.string    :status                    # open, suspended, cancelled, ...
      t.datetime  :offer_expiration
      t.datetime  :contract_maturation
      t.tsrange   :maturation_period
      # ----- statement start -----
      t.integer  :repo_id
      t.integer  :bug_id
      t.string   :bug_title
      t.string   :bug_status
      t.string   :bug_labels
      # ----- statement end -----
      t.jsonb    :jfields,  null: false, default: '{}'
      t.string   :exref
      t.string   :uuref
    end
    add_index :offers, :type
    add_index :offers, :user_id
    add_index :offers, :counter_id
    add_index :offers, :poolable
    add_index :offers, :exref
    add_index :offers, :uuref
    add_index :offers, :repo_id
    add_index :offers, :bug_id
    add_index :offers, :maturation_period, using: :gist
    add_index :offers, :jfields          , using: :gin

    create_table :positions do |t|
      t.integer  :offer_id
      t.integer  :escrow_id
      t.integer  :parent_id
      t.string   :side            # 'bid' or 'ask'
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :positions, :offer_id
    add_index :positions, :escrow_id
    add_index :positions, :parent_id
    add_index :positions, :exref
    add_index :positions, :uuref
    add_index :positions, :side

    create_table :escrows do |t|
      t.integer  :contract_id
      t.integer  :parent_id
      t.string   :exref
      t.string   :uuref
      t.timestamps
    end
    add_index :escrows, :contract_id
    add_index :escrows, :parent_id
    add_index :escrows, :exref
    add_index :escrows, :uuref

    create_table :contracts do |t|
      t.string   :type                # GitHub, BugZilla, ...
      t.string   :mode                # reward, forecast
      t.string   :status              # open, matured, resolved
      t.string   :awarded_to          # bidder, asker
      t.datetime :contract_maturation
      t.integer  :volume
      t.float    :price
      # ----- statement start
      t.integer  :repo_id
      t.integer  :bug_id
      t.string   :bug_title
      t.string   :bug_status
      t.string   :bug_labels
      # ----- statement end
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
      t.float    :token_balance, default: 0.0
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
