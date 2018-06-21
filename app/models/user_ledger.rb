class UserLedger < ApplicationRecord

  with_options primary_key: "uuid" do
    belongs_to :user       , foreign_key: "user_uuid"
    belongs_to :paypro     , foreign_key: "paypro_uuid"
  end

end

# == Schema Information
#
# Table name: user_ledgers
#
#  id          :bigint(8)        not null, primary key
#  uuid        :string
#  user_uuid   :string
#  paypro_uuid :string
#  sequence    :integer
#  name        :string
#  currency    :string
#  balance     :float            default(0.0)
#  jfields     :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
