# Bugmark Graphql

## Starting Up

    > rails db:create
    > rails db:migrate

## Load Some Data

    $ script/bot/fast_load
    
## Graphiql Web 

Visit `https://<YOURHOST>/graphiql`
user/pass = `admin@bugmark.net`/`bugmark`

## Graphiql Curl

    curl -u admin@bugmark.net:bugmark -X POST \
      -H "Content-Type: application/json" \
      --data '{"query": "{users {id}}"}' \
      http://voda:3000/graphql

## Graphiql Schema

    query { __schema { types }}
    query { __schema { types {name} }}

## Graphiql Queries

    query { users { id }}
    query { offers { id }}

## Graphiql Commands

TBD
