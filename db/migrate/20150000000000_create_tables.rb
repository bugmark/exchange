class CreateTables < ActiveRecord::Migration[5.1]
  def change

    enable_extension "hstore"

    create_table :trackers do |t|
      t.string   :type       # Tracker::BugZilla, Tracker::GitHub, Tracker::Cvrf
      t.string   :uuid
      t.string   :name       # bugmark/exchange
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: {}
      t.datetime :synced_at
      t.string   :exid
      t.timestamps
    end
    add_index :trackers, :uuid
    add_index :trackers, :exid
    add_index :trackers, :type
    add_index :trackers, :name
    add_index :trackers, :jfields, using: :gin
    add_index :trackers, :xfields, using: :gin

    create_table :issues do |t|
      t.string   :type             # BugZilla, GitHub, Cve
      t.string   :uuid
      t.string   :exid
      t.integer  :sequence
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: {}
      t.datetime :synced_at
      t.timestamps
    end
    add_index :issues, :type
    add_index :issues, :uuid
    add_index :issues, :exid
    add_index :issues, :sequence
    add_index :issues, :jfields, using: :gin
    add_index :issues, :xfields, using: :gin

    create_table :offers do |t|
      t.string   :uuid
      t.string   :type                      # BuyFixed, BuyUnfixed, SellFixed, SellUnfixed
      t.string   :tracker_type              # BugZilla, GitHub, CVE
      t.string   :user_uuid                 # the party who made the offer
      t.string   :ledger_uuid               # the ledger used to make the offer
      t.string   :prototype_uuid            # optional offer prototype
      t.string   :amendment_uuid            # the generating amendment
      t.string   :salable_position_uuid     # for SaleOffers - a Position
      t.integer  :volume                    # Greater than zero
      t.float    :price                     # between 0.00 and 1.00
      t.float    :value
      t.boolean  :poolable, default: false  # for reserve pooling
      t.boolean  :aon     , default: false  # All Or None
      t.string   :status                    # open, suspended, cancelled, ...
      t.datetime :expiration
      t.tsrange  :maturation_range
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: {}

      t.timestamps
    end
    add_index :offers, :uuid
    add_index :offers, :type
    add_index :offers, :user_uuid
    add_index :offers, :prototype_uuid
    add_index :offers, :amendment_uuid
    add_index :offers, :salable_position_uuid
    add_index :offers, :poolable
    add_index :offers, :volume
    add_index :offers, :price
    add_index :offers, :value
    add_index :offers, :maturation_range, using: :gist
    add_index :offers, :xfields         , using: :gin
    add_index :offers, :jfields         , using: :gin

    create_table :contracts do |t|
      t.string   :uuid
      t.integer  :prototype_uuid      # optional contract prototype
      t.string   :type                # GitHub, BugZilla, ...
      t.string   :status              # open, matured, resolved
      t.string   :awarded_to          # fixed, unfixed
      t.datetime :maturation
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: {}
      t.timestamps
    end
    add_index :contracts, :uuid
    add_index :contracts, :prototype_uuid
    add_index :contracts, :xfields, using: :gin
    add_index :contracts, :jfields, using: :gin

    # ----- STATEMENT FIELDS -----
    %i(issues offers contracts).each do |table|
      add_column table, :stm_issue_uuid   , :string
      add_column table, :stm_tracker_uuid , :string
      add_column table, :stm_title        , :string
      add_column table, :stm_body         , :string
      add_column table, :stm_status       , :string
      add_column table, :stm_labels       , :string
      add_column table, :stm_trader_uuid  , :string
      add_column table, :stm_group_uuid   , :string
      add_column table, :stm_currency     , :string
      add_column table, :stm_paypro_uuid  , :string
      add_column table, :stm_comments     , :jsonb  , null: false, default: {}
      add_column table, :stm_jfields      , :jsonb  , null: false, default: {}
      add_column table, :stm_xfields      , :hstore , null: false, default: {}

      add_index table, :stm_tracker_uuid
      add_index table, :stm_issue_uuid
      add_index table, :stm_title
      add_index table, :stm_body
      add_index table, :stm_status
      add_index table, :stm_labels
      add_index table, :stm_trader_uuid
      add_index table, :stm_group_uuid
      add_index table, :stm_comments , :using => :gin
      add_index table, :stm_jfields  , :using => :gin
      add_index table, :stm_xfields  , :using => :gin
    end

    create_table :positions do |t|
      t.string   :uuid
      t.string   :offer_uuid
      t.string   :user_uuid
      t.string   :amendment_uuid
      t.string   :escrow_uuid
      t.string   :parent_uuid
      t.integer  :volume
      t.float    :price
      t.float    :value
      t.string   :side            # 'fixed' or 'unfixed'
      t.timestamps
    end
    add_index :positions, :uuid
    add_index :positions, :offer_uuid
    add_index :positions, :user_uuid
    add_index :positions, :amendment_uuid
    add_index :positions, :escrow_uuid
    add_index :positions, :parent_uuid
    add_index :positions, :volume
    add_index :positions, :price
    add_index :positions, :value
    add_index :positions, :side

    create_table :escrows do |t|
      t.string   :uuid
      t.string   :type
      t.integer  :sequence      # SORTABLE POSITION USING ACTS_AS_LIST
      t.string   :contract_uuid
      t.string   :amendment_uuid
      t.float    :fixed_value  ,     default: 0.0
      t.float    :unfixed_value,     default: 0.0
      t.timestamps
    end
    add_index :escrows, :uuid
    add_index :escrows, :type
    add_index :escrows, :contract_uuid
    add_index :escrows, :amendment_uuid
    add_index :escrows, :sequence

    create_table :amendments do |t|
      t.string   :uuid
      t.string   :type               # expand, transfer, reduce, resolve
      t.integer  :sequence           # SORTABLE POSITION USING ACTS_AS_LIST
      t.string   :contract_uuid
      t.hstore   :xfields,  null: false, default: {}
      t.jsonb    :jfields,  null: false, default: {}
      t.timestamps
    end
    add_index :amendments, :uuid
    add_index :amendments, :sequence
    add_index :amendments, :contract_uuid
    add_index :amendments, :xfields, using: :gin
    add_index :amendments, :jfields, using: :gin

    create_table :users do |t|
      t.string   :uuid
      t.string   :exid
      t.boolean  :admin
      t.string   :auth_token
      t.float    :balance, default: 0.0
      t.jsonb    :jfields , null: false, default: {}
      t.datetime :last_seen_at
      t.timestamps
    end
    add_index :users, :uuid
    add_index :users, :exid
    add_index :users, :auth_token
    add_index :users, :jfields, using: :gin

    create_table :user_ledgers do |t|
      t.string   :uuid
      t.string   :user_uuid
      t.string   :paypro_uuid
      t.integer  :sequence      # SORTABLE POSITION USING ACTS_AS_LIST
      t.string   :name
      t.string   :currency
      t.float    :balance , default: 0.0
      t.string   :status  , default: 'open'
      t.jsonb    :jfields , null: false, default: {}
      t.timestamps
    end
    add_index :user_ledgers, :uuid
    add_index :user_ledgers, :user_uuid
    add_index :user_ledgers, :paypro_uuid
    add_index :user_ledgers, :sequence
    add_index :user_ledgers, :name
    add_index :user_ledgers, :currency
    add_index :user_ledgers, :balance
    add_index :user_ledgers, :status
    add_index :user_ledgers, :jfields, using: :gin

    create_table :user_groups do |t|
      t.string   :uuid
      t.string   :owner_uuid
      t.string   :name
      t.string   :tags
      t.jsonb    :jfields , null: false, default: {}
      t.string   :status  , default: 'open'           # open | closed
      t.timestamps
    end
    add_index :user_groups, :uuid
    add_index :user_groups, :owner_uuid
    add_index :user_groups, :name
    add_index :user_groups, :tags
    add_index :user_groups, :status
    add_index :user_groups, :jfields, using: :gin

    create_table :user_memberships do |t|
      t.string :uuid
      t.string :user_uuid
      t.string :group_uuid
      t.string :status       , default: 'active'   # active | suspended
    end
    add_index :user_memberships, :uuid
    add_index :user_memberships, :user_uuid
    add_index :user_memberships, :group_uuid
    add_index :user_memberships, :status

    create_table :paypros do |t|
      t.string :uuid
      t.string :name
      t.string :status    , default: 'open'
      t.string :currency
      t.string :pubkey
      t.timestamps
    end
    add_index :paypros, :uuid
    add_index :paypros, :name
    add_index :paypros, :currency
    add_index :paypros, :status

    # the event store...
    create_table :events do |t|
      t.string     :event_type   # inheritance column
      t.string     :event_uuid   # uuid for the event
      t.string     :cmd_type     # type of command that created the event
      t.string     :cmd_uuid     # uuid of command that created the event
      t.string     :local_hash   # [event_uuid, payload].digest
      t.string     :chain_hash   # [local_hash, chain_hash].digest
      t.jsonb      :payload    , null: false, default: {}
      t.jsonb      :jfields    , null: false, default: {}
      t.string     :user_uuids , array: true, default: []
      t.string     :tags
      t.string     :note
      t.datetime   :projected_at
      t.timestamps
    end
    add_index :events, :event_type
    add_index :events, :event_uuid
    add_index :events, :cmd_type
    add_index :events, :cmd_uuid
    add_index :events, :local_hash
    add_index :events, :chain_hash
    add_index :events, :payload    , using: :gin
    add_index :events, :jfields    , using: :gin
    add_index :events, :user_uuids , using: :gin
    add_index :events, :tags
    add_index :events, :note
    add_index :events, :projected_at

    # holds an event counter for a projection
    create_table :projections do |t|
      t.string  :name
      t.integer :event_counter
      t.timestamps
    end
  end
end
