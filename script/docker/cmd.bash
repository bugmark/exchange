#!/usr/bin/env bash

export POSTGRES_HOST=postgres

echo "----- BUNDLE INSTALL -----"
bundle install

echo "----- DB CREATE -----" \
  && rails db:create \
  && echo "----- DB MIGRATE -----" \
  && rails db:migrate \
  && echo "----- RAILS SERVER -----" \
  && rails server -b 0.0.0.0 \
