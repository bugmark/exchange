class Paypro < ApplicationRecord

  with_options primary_key: 'uuid' do
    has_many :ledgers  , foreign_key: 'paypro_uuid'
  end
  has_many :users, :through => :ledgers

end

# == Schema Information
#
# Table name: paypros
#
#  id         :bigint(8)        not null, primary key
#  uuid       :string
#  name       :string
#  status     :string           default("open")
#  currency   :string
#  pubkey     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#