require 'securerandom'

class EventLine < ApplicationRecord

  before_save :default_values

  validate :type, presence: true

  private

  def default_values
    prev = EventLine.last
    self.uuref      ||= SecureRandom.uuid
    self.local_hash   = [self.uuref, data].hash
    self.chain_hash   = [prev&.chain_hash, self.local_hash].hash
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
