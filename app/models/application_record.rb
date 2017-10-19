require 'securerandom'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_save :update_uuref

  def xid
    "#{side}.#{self&.id || 0}"
  end

  def to_i
    self.id
  end

  private

  def update_uuref
    self.uuref ||= SecureRandom.uuid
  end
end
