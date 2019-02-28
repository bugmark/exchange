# Host info methods
module InfoMethods
  def host_name()   `hostname`.chomp     end
  def host_time()   BugmTime.now         end
  def day_offset()  BugmTime.day_offset  end
  def hour_offset() BugmTime.hour_offset end
end

# Host info type
class Types::Exc::Host::InfoType < Types::Base::Object
  include InfoMethods
  field :host_name  , String, null: true, description: 'Server hostname'
  field :host_time  , String, null: true, description: 'Exchange time'
  field :day_offset , String, null: true, description: 'Exchange day offset'
  field :hour_offset, String, null: true, description: 'Exchange day offset'
end
