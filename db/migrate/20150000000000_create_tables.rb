class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :repos do |t|
      t.string   :format          # GitHub, CVRF
      t.string   :name            # mvscorg/xdmarket
      t.string   :url
      t.datetime :synced_at
      t.timestamps
    end

    create_table :bugs do |t|
      t.integer  :repo_id
      t.string   :api_url
      t.string   :http_url
      t.string   :title
      t.string   :status
      t.text     :labels, array: true, default: []
      t.datetime :synced_at
      t.timestamps
    end

    create_table :contracts do |t|
      t.string   :type
      t.float    :amount
      t.integer  :publisher_id
      t.integer  :counterparty_id
      t.string   :xfields
      t.datetime :expire_at
      t.timestamps
    end

    create_table :users do |t|
      t.boolean  :admin
      t.timestamps
    end

    create_table :wallets do |t|
      t.string   :user_id
      t.string   :pub_key
      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.timestamps
    end

  end
end
