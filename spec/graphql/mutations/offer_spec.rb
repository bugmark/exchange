require 'rails_helper'
require 'rails_support'

# RSpec.describe 'GQL Offer Mutation' do #
#   include_context 'GraphQL'
#
#   let(:user) { FB.create(:user).project.user }
#
#   describe 'offer_create_bu' do
#     let(:query_string) do
#       %Q[mutation { offer_create_bu(
#         user_uuid: "#{user.uuid}",
#         price: 0.4,
#         volume: 10) { id } }]
#     end
#
#     it 'generates an offer' do
#       expect(Offer.count).to eq(0)
#       expect(results).to_not be_nil
#       expect(results.to_h).to be_a(Hash)
#       expect(Offer.count).to eq(1)
#     end
#   end
#
#   describe 'offer_create_bf' do
#     let(:query_string) {
#       %Q[mutation { offer_create_bf(
#         user_uuid: "#{user.uuid}",
#         price: 0.4,
#         volume: 10) { id } }]
#     }
#
#     it 'generates an offer' do
#       expect(Offer.count).to eq(0)
#       expect(results).to_not be_nil
#       expect(results.to_h).to be_a(Hash)
#       expect(Offer.count).to eq(1)
#     end
#   end
# end
