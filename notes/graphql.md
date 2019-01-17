# Bugmark Graphql

## Starting Up

    > bundle install
    > rails db:create
    > rails db:migrate

## Load Some Data

    $ script/bot/fast_load
    
## Graphiql Web 

Visit `https://<YOURHOST>/graphiql`
user/pass = `admin@bugmark.net`/`bugmark`

Check out the **Documentation Explorer**!

Try these Graphiql inputs:

    mutation deposit {
      userDeposit(id: 1, amount: 10.0)
    }

    query check {
      user(id: 1) {id balance}
    }

## Graphiql Curl

    curl -u admin@bugmark.net:bugmark -X POST \
      -H "Content-Type: application/json" \
      --data '{"query": "{users {id}}"}' \
      http://voda:3000/graphql

## Graphiql CLI

Install Graphql-CLI

    $ npm install -g graphql-cli

Base64 encode your username/password

    $ echo 'admin@bugmark.net:bugmark' | base64

Gives:

    YWRtaW5AYnVnbWFyay5uZXQ6YnVnbWFyawo=

Update your `.graphqlconfig` file:
    
    {
      "projects": {
        "bugmark": {
          "schemaPath": "schema.graphql",
          "extensions": {
            "endpoints": {
              "voda": {
                "url": "http://voda:3000/graphql",
                "headers": {"Authorization": "Basic YWRtaW5AYnVnbWFyay5uZXQ6YnVnbWFyawo="}
              }
            }
          }
        }
      }
    }

Now use the CLI:

    $ graphql ping

## Graphiql Queries

    query userList { users { id }}
    query offerList { offers { id }}

## Graphiql Mutations

    mutation userDeposit { 
      userDeposit(id: 1, amount: 10.0)
    }
