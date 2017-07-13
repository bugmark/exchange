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
#  amount          :float
#  publisher_id    :integer
#  counterparty_id :integer
#  xfields         :string
#  expire_at       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
