module Types
  QueryType = GraphQL::ObjectType.new.tap do |root_type|
    root_type.name = 'Query'
    root_type.description = 'The query root'
    root_type.interfaces = []
    root_type.fields = Util::FieldCombiner.combine(
      [
        Queries::Test       ,
        Queries::Host       ,
        Queries::User       ,
        Queries::Amendment  ,
        Queries::Escrow     ,
        Queries::Tracker    ,
        Queries::Position   ,
        Queries::Issue      ,
        Queries::Offer      ,
        Queries::Contract   ,
        Queries::Event
      ]
    )
  end
end
