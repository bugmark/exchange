# - [ ] GraphQL Command: offerCreateClone
# - [ ] GraphQL Command: offerCreateCounter
# - [ ] GraphQL Command: offerCreateSell
# - [ ] GraphQL Command: offerExpire
# - [ ] GraphQL Command: offerSuspend

module Mutations
  Offer = GraphQL::ObjectType.define do

    # -------------------------------------------------------------------------
    field :offer_create_bu, Types::Exchange::OfferType do
      description "Create a Offer to Buy Unfixed"
      argument :user_uuid      , !GraphQL::STRING_TYPE
      argument :price          , !GraphQL::FLOAT_TYPE
      argument :volume         , !GraphQL::INT_TYPE
      argument :stm_issue_uuid , GraphQL::STRING_TYPE
      argument :expiration     , GraphQL::Types::ISO8601DateTime
      argument :maturation     , GraphQL::Types::ISO8601DateTime
      argument :poolable       , types.Boolean
      argument :aon            , types.Boolean

      resolve ->(_obj, args, _ctx) do
        opts = {
          user_uuid:      args[:user_uuid]                                   ,
          price:          args[:price]                                       ,
          volume:         args[:volume]                                      ,
          stm_issue_uuid: args[:stm_issue_uuid]                              ,
          stm_status:     "closed"                                           ,
          expiration:     args[:expiration] || (Time.now + 1.day).iso8601    ,
          maturation:     args[:maturation] || (Time.now + 12.hours).iso8601 ,
          poolable:       args[:poolable]   || false                         ,
          aon:            args[:aon]        || false                         ,
        }
        result = OfferCmd::CreateBuy.new(:offer_bu, opts).project
        result.offer
      end
    end

    # -------------------------------------------------------------------------
    field :offer_create_bf, Types::Exchange::OfferType do
      description "Create a Offer to Buy Fixed"
      argument :user_uuid      , !GraphQL::STRING_TYPE
      argument :price          , !GraphQL::FLOAT_TYPE
      argument :volume         , !GraphQL::INT_TYPE
      argument :stm_issue_uuid , GraphQL::STRING_TYPE
      argument :expiration     , GraphQL::Types::ISO8601DateTime
      argument :maturation     , GraphQL::Types::ISO8601DateTime
      argument :poolable       , types.Boolean
      argument :aon            , types.Boolean

      resolve ->(_obj, args, _ctx) do
        opts = {
          user_uuid:      args[:user_uuid]                                   ,
          price:          args[:price]                                       ,
          volume:         args[:volume]                                      ,
          stm_issue_uuid: args[:stm_issue_uuid]                              ,
          stm_status:     "open"                                             ,
          expiration:     args[:expiration] || (Time.now + 1.day).iso8601    ,
          maturation:     args[:maturation] || (Time.now + 12.hours).iso8601 ,
          poolable:       args[:poolable]   || false                         ,
          aon:            args[:aon]        || false                         ,
        }
        result = OfferCmd::CreateBuy.new(:offer_bu, opts).project
        result.offer
      end
    end

    # -------------------------------------------------------------------------
    field :offer_cancel, Types::Exchange::OfferType do
      description "Cancel an Offer"
      argument :offer_uuid, !GraphQL::STRING_TYPE

      resolve ->(_obj, args, _ctx) do
        offer_uuid = args[:offer_uuid]
        offer = Offer.find_by_uuid(args[:offer_uuid])
        result = OfferCmd::Cancel.new(offer).project
        result.offer
      end
    end

  end
end
