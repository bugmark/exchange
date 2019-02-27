module Queries
  Amendment = GraphQL::ObjectType.define do

    field :amendment, Types::Ex::AmendmentType do
      description 'Amendment Info'
      argument :id, GraphQL::INT_TYPE
      resolve ->(_obj, args, _ctx) do
        ::Amendment.find(args[:id])
      end
    end

    field :amendments, types[Types::Ex::AmendmentType] do
      description 'Amendment list'
      resolve ->(_obj, _args, _ctx) do
        ::Amendment.all
      end
    end

  end
end
