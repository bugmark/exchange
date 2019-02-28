module Queries
  Offer = GraphQL::ObjectType.define do

    field :offer, Types::Exc::OfferType do
      description 'Offer info'
      argument :id, !types.Int, 'Offer ID'
      resolve ->(_obj, args, _ctx) do
        ::Offer.find(args[:id])
      end
    end

    field :offers, types[Types::Exc::OfferType] do
      description 'Offer list'
      argument :limit, types.Int, 'Max number of records to return'
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Offer.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
