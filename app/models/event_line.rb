require 'digest/sha2'

class EventLine < ApplicationRecord

  before_save :default_values

  private

  def default_values
    self.local_sha2 = Digest::SHA2.hexdigest
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
