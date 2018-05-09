require 'json'
require 'ext/hash'

class Event < ApplicationRecord

  self.inheritance_column = :event_type

  before_validation :default_values

  validates :cmd_type, presence: true
  validates :cmd_uuid, presence: true

  jsonb_accessor :jfields, :etherscan_url => :string

  class << self
    # generate jsonb fields for a class
    def jsonb_fields_for(field, klas, opts = {})
      fields = klas.attribute_names.reduce({}) do |acc, name|
        sname = name.to_s
        acc[sname] = klas.columns_hash[sname]&.type
        acc
      end

      new_fields = fields
        .without_blanks
        .merge(opts.fetch(:extras, {}))
        .without(*(opts.fetch(:exclude, [])))
        .delete_if {|k, v| %i(jsonb hstore tsrange).include?(v)}
        .delete_if {|k, v| %w(created_at updated_at).include?(k)}

      new_fields.each do |key, val|
        jsonb_accessor field, {key => val}
      end
    end

    def for_user(user)
      # user_id = user.to_i
      where("? = any(user_uuids)", user.uuid)
      # where(false)
    end
  end

  def influx_tags()   {} end
  def influx_fields() {} end

  def ev_cast
    if valid?
      if new_object&.save
        self.projected_at = BugmTime.now
        self.send(:save!) unless BMX_SAVE_EVENTS  == "FALSE"
        point_cast        unless BMX_SAVE_METRICS == "FALSE"
      else
        # raise "EVENT OBJECT DID NOT SAVE"
      end
      new_object
    else
      nil
    end
  end

  def point_cast
    return unless InfluxUtil.has_influx?
    return unless USE_INFLUX == true
    return if Rails.env.test?
    mname = self.class.name.gsub("Event::", "")
    args  = {
      tags:      base_tags.merge(influx_tags)      ,
      values:    base_fields.merge(influx_fields)  ,
      timestamp: BugmTime.now.to_i
    }
    InfluxStats.write_point mname, args
  end

  def cast_object
    raise "ERROR: Call in SubClass"
  end

  def new_object
    @cast_element ||= cast_object
  end

  private

  def base_tags
    {
      cmd_type:   self.cmd_type.gsub("::", "_").gsub("Cmd", "")     ,
      event_type: self.event_type.gsub("Event::", "")
    }
  end

  def base_fields
    {
      id: self.id
    }
  end

  def save(*)
    super
  end

  def default_values
    prev = Event.last
    self.payload     ||= {}
    self.event_uuid  ||= SecureRandom.uuid
    self.local_hash    = Digest::MD5.hexdigest([self.event_uuid, payload].to_json)
    self.chain_hash    = Digest::MD5.hexdigest([prev&.chain_hash, self.local_hash].to_json)
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :bigint(8)        not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
