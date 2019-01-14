# Bugmark Graphql

## Starting Up

    > rails db:create
    > rails db:migrate

## Load Some Data

    $ script/bot/fast_load
    
## Graphiql Authentication

Visit `https://<YOURHOST>/graphiql`
user/pass = `admin@bugmark.net`/`bugmark`

## Graphiql Schema

    query { __schema { types }}
    query { __schema { types {name} }}

## Graphiql Queries

    query { users { id }}
    query { offers { id }}

## Graphiql Commands

TBD
