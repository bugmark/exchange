require 'securerandom'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_save :update_uuref

  private

  def update_uuref
    self.uuref ||= SecureRandom.uuid
  end
end
