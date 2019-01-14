# Bugmark Graphql

## Starting Up

    > rails db:create
    > rails db:migrate

## Load Some Data

    $ script/bot/fast_load
    
## Graphiql Authentication

Visit `https://<YOURHOST>/graphiql`
user/pass = `admin@bugmark.net`/`bugmark`

## Graphiql Queries

    { users { id }}
    { offers { id }}

## Graphiql Commands

TBD
