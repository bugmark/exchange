# Bugmark Graphql

## Starting Up

    > cd exchange           # cd to the exchange directory
    > bundle install        # install gem dependencies
    > rails db:create       # create database
    > rails db:migrate      # create database tables
    > script/bot/fast_buy   # generate seed data
    
## Running the Development Console

If you are starting from a raw console, you can bring up a development console
with a single command:

    > script/dev/session    # start development console

If you are starting from within a TMUX/TMATE session, start the development
console with two commands.

In terminal one:

    > script/dev/rspec    # start the test runner

In terminal two:

    > script/dev/puma     # start the dev server
    
## Graphiql Web 

Visit `https://<YOURHOST>:<yourport>/graphiql`
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
