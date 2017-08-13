class EventLine < ApplicationRecord

  before_save :default_values

  private

  def default_values
    prev = EventLine.last
    self.local_hash = data.hash
    self.chain_hash = [prev&.chain_hash, self.local_hash].hash
  end
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
