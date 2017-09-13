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
