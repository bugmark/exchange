class EventLine < ApplicationRecord

  before_validation :default_values

  validates :klas, presence: true

  private

  def default_values
    prev = EventLine.last
    self.data       ||= {}
    self.uuref      ||= SecureRandom.uuid
    self.local_hash   = [self.uuref, data].hash.to_s
    self.chain_hash   = [prev&.chain_hash, self.local_hash].hash.to_s
  end
end

# == Schema Information
#
# Table name: event_lines
#
#  id         :integer          not null, primary key
#  klas       :string
#  uuref      :string
#  local_hash :integer
#  chain_hash :integer
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
