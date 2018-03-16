require 'securerandom'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_save :update_uuid

  def xid
    "#{xtag}.#{self&.id || 0}"
  end

  def to_i
    self.id
  end

  def dump
    select_subset = self.class.where(id: self.id).select_subset
    output = Hirb::Helpers::AutoTable.render(select_subset)
    puts output.gsub /\n\d+ row.*/, ""
  end
  alias_method :ds, :dump
  alias_method :ss, :dump

  def dumptree
    dt_hdr
    dump
  end
  alias_method :dt, :dumptree

  def dt_hdr
    puts ">>>>> #{self.class.to_s} #{self.id}"
  end

  def dt_ftr(msg = "NNN")
    puts "xxxxx #{msg}"
  end

  private

  def update_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
