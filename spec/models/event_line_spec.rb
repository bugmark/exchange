require 'rails_helper'

RSpec.describe EventLine, type: :model do

end

# == Schema Information
#
# Table name: event_lines
#
#  id         :integer          not null, primary key
#  type       :string
#  uuref      :string
#  local_hash :integer
#  chain_hash :integer
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
