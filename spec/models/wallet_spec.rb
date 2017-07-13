require 'rails_helper'

RSpec.describe Wallet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: wallets
#
#  id         :integer          not null, primary key
#  user_id    :string
#  pub_key    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
