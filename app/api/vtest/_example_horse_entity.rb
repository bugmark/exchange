# module API
#   module Entities
#     class Horse < Grape::Entity
#       include API::Entities::Defaults
#
#       expose :size, documentation: { type: Integer }
#       expose :age, documentation: { type: Integer }
#       expose :gender, documentation: { type: Integer }
#       expose :hussar, using: Entities::Base, documentation: { type: Integer, desc: 'Identity of associated Hussar' }
#     end
#   end
# end
