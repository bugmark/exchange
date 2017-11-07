# module V1
#   class Test < Grape::API
#
#     resource :bugs do
#       desc "Return all bugs"
#       get "", :root => :bugs do
#         Bug.all
#       end
#     end
#   end
# end
