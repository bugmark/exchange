class Wallet < ApplicationRecord
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
