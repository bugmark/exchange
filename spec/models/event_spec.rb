require 'rails_helper'

RSpec.describe Event, type: :model do


end

# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  type       :string
#  uuref      :string
#  local_hash :string
#  chain_hash :string
#  payload    :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
