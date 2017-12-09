class EventLine < ApplicationRecord

  before_validation :default_values

  validates :klas, presence: true

  jsonb_accessor   :jfields , :etherscan_url => :string

  class << self
    def for_user(user)
      user_id = user.to_i
      where("? = any(user_ids)", user_id)
    end
  end

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
#  local_hash :string
#  chain_hash :string
#  data       :jsonb            not null
#  jfields    :jsonb            not null
#  user_ids   :integer          default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
