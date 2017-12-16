require 'json'

class Event < ApplicationRecord

  before_validation :default_values

  validates :cmd_type, presence: true
  validates :cmd_uuid, presence: true

  class << self
    def for_user(user)
      # user_id = user.to_i
      # where("? = any(user_uuids)", user_id)
      where(false)
    end
  end

  def ev_cast
    if valid?
      if cached_cast_object&.save
        self.projected_at = BugmTime.now
        self.send(:save!)
      end
      cached_cast_object
    else
      nil
    end
  end

  # def valid?(*)
  #   if super && cached_cast_object.valid?
  #     true
  #   else
  #     cached_cast_object.valid?
  #     cached_cast_object.errors.each do |field, error|
  #       errors.add(field, error)
  #     end
  #   end
  # end

  def cast_object
    raise "ERROR: Call in SubClass"
  end

  private

  def save(*)
    super
  end

  def cached_cast_object
    @cast_element ||= cast_object
  end

  def default_values
    prev = Event.last
    self.data        ||= {}
    self.uuid        ||= SecureRandom.uuid
    self.local_hash    = Digest::MD5.hexdigest([self.uuid, data].to_json)
    self.chain_hash    = Digest::MD5.hexdigest([prev&.chain_hash, self.local_hash].to_json)
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string
#  uuid         :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  data         :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
