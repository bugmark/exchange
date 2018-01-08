# module API
#   class Horses < Grape::API
#     include API::Defaults
#
#     resources :horses do
#       desc 'Get all horses',
#         is_array: true,
#         http_codes: [
#           { code: 200, message: 'get Horses', model: Entities::Horse },
#           { code: 422, message: 'HorsesOutError', model: Entities::ApiError }
#         ]
#       get do
#         horses = Horse.all
#         present :total_page, 10
#         present :per_page, 20
#         present :horses, horses, with: Entities::Horse
#       end
#
#       desc 'Returns specific horse.' do
#         http_codes [
#           { code: 422, message: 'HorsesOutError', model: Entities::ApiError }
#         ]
#
#       end
#       params do
#         requires :id, type: Integer, desc: 'Identifier of Horse.', documentation: { example: '1'}
#       end
#       get ':id' do
#         horse = Horse.find_by_id(params[:id])
#         present horse, with: Entities::Horse
#       end
#
#       desc 'Create a horse.' do
#         http_codes [
#           {code: 201, message: 'Horse created'},
#           {code: 422, message: 'Validation Errors', model: Entities::ApiError}
#         ]
#       end
#       params do
#         requires :name, type: String, desc: 'Name of Horse to create'
#         optional :hussar_id, type: Integer, desc: 'Associated Hussar to create'
#       end
#       post do
#         horse = Horse.create!({name: params[:name]})
#         hussar = Hussar.find_by_id(params[:hussar_id])
#         hussar.horses << horse
#
#         present horse, with: Entities::Horse
#       end
#
#       desc "Update a horse." do
#         http_codes [
#           {code: 422, message: 'Validation Errors', model: Entities::ApiError}
#         ]
#       end
#       params do
#         requires :id, type: Integer, desc: 'Identity of Horse', documentation: { example: 1}
#         optional :name, type: String, desc: 'Name of Horse', documentation: { example: 'Jon'}
#         optional :hussar_id, type: Integer, desc: 'Associated Hussar of Horse', documentation: { example: '1'}
#       end
#       put ":id" do
#         horse = Horse.find_by_id(params[:id])
#         horse.name = params[:name]
#         horse.hussar_id = params[:hussar_id]
#         horse.save!
#         present horse, with: Entities::Horse
#       end
#
#
#       desc 'Delete a Horse'
#       params do
#         requires :id, type: Integer, desc: 'Identity of Horse to delete', documentation: { example: '1'}
#       end
#       delete ':id' do
#         Horse.destroy(params[:id])
#       end
#     end
#   end
# end
