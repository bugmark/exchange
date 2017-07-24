require 'rails_helper'

RSpec.describe Contract, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: contracts
#
#  id              :integer          not null, primary key
#  type            :string
#  publisher_id    :integer
#  counterparty_id :integer
#  currency_type   :string
#  currency_amount :float
#  terms           :string
#  expire_at       :datetime
#  bug_id          :integer
#  repo_id         :integer
#  title           :string
#  status          :string
#  labels          :string
#  assert_match    :boolean
#  jfields         :jsonb            not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
