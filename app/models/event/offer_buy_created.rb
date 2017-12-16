require "ext/hash"

class Event::OfferBuyCreated < Event

  jsonb_accessor :data, "type"           => :string
  jsonb_accessor :data, "uuid"           => :string
  jsonb_accessor :data, "user_uuid"      => :string
  jsonb_accessor :data, "volume"         => :integer
  jsonb_accessor :data, "price"          => :float
  jsonb_accessor :data, "aon"            => [:boolean, default: false]
  jsonb_accessor :data, "poolable"       => [:boolean, default: false]
  jsonb_accessor :data, "maturation"     => :datetime
  jsonb_accessor :data, "maturation_min" => :datetime
  jsonb_accessor :data, "maturation_max" => :datetime
  jsonb_accessor :data, "stm_bug_id"     => :string
  jsonb_accessor :data, "stm_repo_id"    => :string
  jsonb_accessor :data, "stm_title"      => :string
  jsonb_accessor :data, "stm_status"     => :string
  jsonb_accessor :data, "stm_labels"     => :string

  validates :uuid     , presence: true
  validates :user_uuid, presence: true
  validates :volume   , presence: true
  validates :price    , presence: true

  private

  def cast_object
    klas = data['type'].constantize
    klas.new(data.without_blanks)
  end

  def user_uuids
    [user_uuid]
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
