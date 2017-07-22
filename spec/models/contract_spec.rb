require 'rails_helper'

RSpec.describe Contract, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: contracts
#
#  id              :integer          not null, primary key
#  bug_id          :integer
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_amount :float
#  currency_type   :string
#  terms           :string
#  jfields         :jsonb            not null
#  expire_at       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
