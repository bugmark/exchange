class EventLine < ApplicationRecord

end

# == Schema Information
#
# Table name: event_lines
#
#  id         :integer          not null, primary key
#  type       :string
#  uuref      :string
#  local_hash :string
#  chain_hash :string
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
