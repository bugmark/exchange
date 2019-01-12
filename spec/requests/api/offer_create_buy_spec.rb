require 'rails_helper'

# include AuthRequestHelper

# describe "API" do
#   context 'GET /offers' do
#     it 'works with valid login' do
#       create_user
#       get "/api/v1/offers.json", env: basic_creds
#       expect(response.status).to eq(200)
#       expect(JSON.parse(response.body)).to be_an(Array)
#     end
#   end
#
#   context 'POST /offers/buy' do
#     def opts(alt = {})
#       {
#         side: "fixed"  ,
#         volume: 10     ,
#         price: 0.9     ,
#       }.merge(alt)
#     end
#
#     FMT = "%y%m%d%h%m"
#
#     it 'posts an offer' do
#       create_user
#       post "/api/v1/offers/buy.json", {params: opts, env: basic_creds}
#       expect(response.status).to eq(201)
#       expect(JSON.parse(response.body)).to be_an(Hash)
#       expect(Offer.count).to eq(1)
#     end
#
#     describe "maturation_offset" do
#       it "runs" do
#         create_user
#         alt = {maturation_offset: "minutes-5"}
#         post "/api/v1/offers/buy.json", {params: opts(alt), env: basic_creds}
#         expect(response.status).to eq(201)
#         expect(JSON.parse(response.body)).to be_an(Hash)
#         expect(Offer.count).to eq(1)
#       end
#
#       it "creates the minute maturation" do
#         create_user
#         alt = {maturation_offset: "minutes-5"}
#         post "/api/v1/offers/buy.json", {params: opts(alt), env: basic_creds}
#         expect(Offer.first.maturation.strftime(FMT)).to eq((BugmTime.now + 5.minutes).strftime(FMT))
#       end
#
#       it "creates the hour maturation" do
#         create_user
#         alt = {maturation_offset: "hours-5"}
#         post "/api/v1/offers/buy.json", {params: opts(alt), env: basic_creds}
#         expect(Offer.first.maturation.strftime(FMT)).to eq((BugmTime.now + 5.hours).strftime(FMT))
#       end
#     end
#   end
# end
